sudo apt update
sudo apt install stow
mv ~/.bashrc ~/.bashrc.bak
stow -d ~/dotfiles/
