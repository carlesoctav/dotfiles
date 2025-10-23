#!/usr/bin/env bash
# description: Install Vespa language server JAR
set -euo pipefail

version="2.4.2"
jar="vespa-language-server_${version}.jar"
url="https://github.com/vespa-engine/vespa/releases/download/lsp-v${version}/${jar}"

tmpdir="$(mktemp -d)"
trap 'rm -rf "${tmpdir}"' EXIT

curl -L "${url}" -o "${tmpdir}/${jar}"
sudo install -m 0644 "${tmpdir}/${jar}" /usr/local/bin/vls.jar
