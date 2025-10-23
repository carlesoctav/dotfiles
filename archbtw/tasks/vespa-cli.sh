#!/usr/bin/env bash
# description: Install Vespa CLI from GitHub release
set -euo pipefail

version="8.538.52"
archive="vespa-cli_${version}_linux_amd64.tar.gz"
url="https://github.com/vespa-engine/vespa/releases/download/v${version}/${archive}"

tmpdir="$(mktemp -d)"
trap 'rm -rf "${tmpdir}"' EXIT

curl -L "${url}" -o "${tmpdir}/${archive}"
tar -xzf "${tmpdir}/${archive}" -C "${tmpdir}"

sudo install -m 0755 "${tmpdir}/vespa-cli_${version}_linux_amd64/bin/vespa" /usr/local/bin/vespa
sudo mkdir -p /usr/local/share/man/man1
sudo cp "${tmpdir}/vespa-cli_${version}_linux_amd64/share/man/man1/"* /usr/local/share/man/man1/
