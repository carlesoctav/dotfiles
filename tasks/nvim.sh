#!/bin/bash

# Download the latest Neovim AppImage
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage

# Make the AppImage executable
chmod +x nvim.appimage
sudo mv ./nvim.appimage /usr/local/bin/nvim
nvim
