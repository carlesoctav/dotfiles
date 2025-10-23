#!/usr/bin/env bash
# description: Authenticate GitHub Copilot device flow (requires jq)
set -euo pipefail

if ! command -v jq &>/dev/null; then
  sudo pacman -S --needed --noconfirm jq
fi

CLIENT_ID='Iv23ctfURkiMfJ4xr5mv'
COMMON_HEADERS=(
  -H 'accept: application/json'
  -H 'content-type: application/json'
  -H 'accept-encoding: gzip,deflate,br'
)

echo "Requesting device and user codes..."
DEVICE_CODE_RESPONSE=$(curl -s --compressed -X POST \
  "${COMMON_HEADERS[@]}" \
  -d "{\"client_id\":\"$CLIENT_ID\",\"scope\":\"read:user\"}" \
  https://github.com/login/device/code)

DEVICE_CODE=$(echo "$DEVICE_CODE_RESPONSE" | jq -r '.device_code')
USER_CODE=$(echo "$DEVICE_CODE_RESPONSE" | jq -r '.user_code')
VERIFICATION_URI=$(echo "$DEVICE_CODE_RESPONSE" | jq -r '.verification_uri')

if [[ "$DEVICE_CODE" == "null" || "$USER_CODE" == "null" || "$VERIFICATION_URI" == "null" ]]; then
    echo "Error: Could not parse device code response."
    echo "$DEVICE_CODE_RESPONSE"
    exit 1
fi

echo "Please visit $VERIFICATION_URI and enter code $USER_CODE to authenticate."

ACCESS_TOKEN="null"
echo "Polling for access token..."
while [[ "$ACCESS_TOKEN" == "null" ]]; do
  CURRENT_POLL_INTERVAL=5
  sleep "$CURRENT_POLL_INTERVAL"

  TOKEN_RESPONSE=$(curl -s --compressed -X POST \
    "${COMMON_HEADERS[@]}" \
    -d "{\"client_id\":\"$CLIENT_ID\",\"device_code\":\"$DEVICE_CODE\",\"grant_type\":\"urn:ietf:params:oauth:grant-type:device_code\"}" \
    https://github.com/login/oauth/access_token)

  if [[ -z "$TOKEN_RESPONSE" ]]; then
    echo "Error: Empty response from token request during polling."
    continue
  fi

  if ! echo "$TOKEN_RESPONSE" | jq -e . >/dev/null 2>&1; then
    echo "Error: Token response is not valid JSON during polling."
    echo "Raw response: $TOKEN_RESPONSE"
    continue
  fi

  ERROR=$(echo "$TOKEN_RESPONSE" | jq -r '.error')
  if [[ "$ERROR" != "null" && "$ERROR" != "authorization_pending" ]]; then
      ERROR_DESCRIPTION=$(echo "$TOKEN_RESPONSE" | jq -r '.error_description')
      echo "Error received from token endpoint: $ERROR_DESCRIPTION"
      INTERVAL=$(echo "$TOKEN_RESPONSE" | jq -r '.interval')
      if ! [[ "$INTERVAL" =~ ^[0-9]+$ ]] || [[ "$INTERVAL" -le 0 ]]; then
          echo "Warning: Invalid or non-positive interval '$INTERVAL' received. Defaulting to 5 seconds."
          INTERVAL=5
      fi
      echo "Slowing down... waiting $INTERVAL seconds."
      sleep "$INTERVAL"
      continue
  fi

  ACCESS_TOKEN=$(echo "$TOKEN_RESPONSE" | jq -r '.access_token')
done

echo "Authentication success: $ACCESS_TOKEN"

echo "Testing Token..."

curl -s "https://api.githubcopilot.com/chat/completions" \
  -X POST \
  -H "Content-Type: application/json" \
  -H "Copilot-Integration-Id: vscode-chat" \
  -H "Authorization: Bearer $ACCESS_TOKEN" \
  -d '{
    "model": "gpt-4.1",
    "messages": [
      {"role": "user", "content": "Answer with \"OK it worked\""}
    ]
}' | jq -r '.choices[0].delta.content'
