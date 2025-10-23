#!/usr/bin/env bash
# description: Install CPU-only PyTorch stack via pip
set -euo pipefail

pip3 install --upgrade pip
pip3 install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu
