#!/bin/bash

# Download the latest Neovim AppImage
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage

# Make the AppImage executable
chmod u+x nvim.appimage
mv ./nvim.appimage /usr/local/bin/nvim
nvim
