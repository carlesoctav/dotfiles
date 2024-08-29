apt update
apt install stow
apt install libfuse2
mv ~/.bashrc ~/.bashrc.bak
stow -d ~/dotfiles/
