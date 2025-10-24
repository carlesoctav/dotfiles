#!/usr/bin/env bash
# description: Install Google Cloud CLI from official tarball
set -euo pipefail

arch="$(uname -m)"
case "${arch}" in
  x86_64)
    archive="google-cloud-cli-linux-x86_64.tar.gz"
    ;;
  aarch64 | arm64)
    archive="google-cloud-cli-linux-arm.tar.gz"
    ;;
  *)
    printf 'Unsupported architecture: %s\n' "${arch}" >&2
    exit 1
    ;;
esac

url="https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/${archive}"
install_dir="/opt/google-cloud-sdk"
bin_dir="/usr/local/bin"

tmpdir="$(mktemp -d)"
trap 'rm -rf "${tmpdir}"' EXIT

curl -L "${url}" -o "${tmpdir}/${archive}"
tar -xf "${tmpdir}/${archive}" -C "${tmpdir}"

if [[ -d "${install_dir}" ]]; then
  printf 'Removing existing installation at %s\n' "${install_dir}"
  sudo rm -rf "${install_dir}"
fi

sudo mkdir -p "$(dirname "${install_dir}")"
sudo cp -a "${tmpdir}/google-cloud-sdk" "${install_dir}"

sudo install -d -m 0755 "${bin_dir}"
for tool in gcloud gsutil bq; do
  sudo ln -sf "${install_dir}/bin/${tool}" "${bin_dir}/${tool}"
done

printf 'Installed Google Cloud CLI to %s\n' "${install_dir}"
printf 'Symlinked gcloud, gsutil, and bq to %s\n' "${bin_dir}"
printf 'Run %s/bin/gcloud init to finish setup.\n' "${install_dir}"
