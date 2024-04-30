sudo apt update
sudo apt install stow
mv ~/.bashrc ~/.bashrc.bak
mv ~/.config ~/.config.bak
stow -d ~/dotfiles/


