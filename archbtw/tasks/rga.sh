#!/usr/bin/env bash
# description: Install ripgrep-all binary release
set -euo pipefail

version="0.10.9"
archive="ripgrep_all-v${version}-x86_64-unknown-linux-musl.tar.gz"
url="https://github.com/phiresky/ripgrep-all/releases/download/v${version}/${archive}"

tmpdir="$(mktemp -d)"
trap 'rm -rf "${tmpdir}"' EXIT

curl -L "${url}" -o "${tmpdir}/${archive}"
tar -xzf "${tmpdir}/${archive}" -C "${tmpdir}"

bindir="${tmpdir}/ripgrep_all-v${version}-x86_64-unknown-linux-musl"
sudo install -m 0755 "${bindir}/rga" /usr/local/bin/rga
sudo install -m 0755 "${bindir}/rga-fzf" /usr/local/bin/rga-fzf
