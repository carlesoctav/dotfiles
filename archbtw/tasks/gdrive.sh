#!/usr/bin/env bash
# description: Install gdrive CLI from GitHub release
set -euo pipefail

version="3.9.1"
archive="gdrive_linux-x64.tar.gz"
url="https://github.com/glotlabs/gdrive/releases/download/${version}/${archive}"

tmpdir="$(mktemp -d)"
trap 'rm -rf "${tmpdir}"' EXIT

curl -L "${url}" -o "${tmpdir}/${archive}"
tar -xvf "${tmpdir}/${archive}" -C "${tmpdir}"

sudo install -m 0755 "${tmpdir}/gdrive" /usr/local/bin/gdrive
printf 'Installed gdrive %s\n' "${version}"
