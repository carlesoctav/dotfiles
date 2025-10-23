#!/usr/bin/env bash
# description: Install ngrok binary from official tarball
set -euo pipefail

version="3.6.0"
archive="ngrok-v${version}-linux-amd64.tgz"
url="https://bin.equinox.io/c/bNyj1mQVY4c/${archive}"

tmpdir="$(mktemp -d)"
trap 'rm -rf "${tmpdir}"' EXIT

curl -L "${url}" -o "${tmpdir}/${archive}"
tar -xzf "${tmpdir}/${archive}" -C "${tmpdir}"

sudo install -m 0755 "${tmpdir}/ngrok" /usr/local/bin/ngrok
printf 'Installed ngrok %s\n' "${version}"
