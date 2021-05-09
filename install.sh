#!/bin/bash

#==============
# Variables
#==============
dotfiles_dir=~/Git/Dotfiles ;
BPurple='\e[1;35m' ;
NC="\e[m" ;
mkdir ~/Git ;
mkdir ~/.config ;

#==============
# Delete existing dot files and folders
#==============
sudo rm -rif ~/.vim > /dev/null 2>&1 ;
sudo rm -rfi ~/.vimrc > /dev/null 2>&1 ;
sudo rm -rfi ~/.bashrc > /dev/null 2>&1 ;
sudo rm -rfi ~/.tmux > /dev/null 2>&1 ;
sudo rm -rfi ~/.tmux.conf > /dev/null 2>&1 ;
sudo rm -rfi ~/.zsh_prompt > /dev/null 2>&1 ;
sudo rm -rfi ~/.zshrc > /dev/null 2>&1 ;
sudo rm -rfi ~/.gitconfig > /dev/null 2>&1 ;
sudo rm -rfi ~/.antigen > /dev/null 2>&1 ;
sudo rm -rfi ~/.antigen.zsh > /dev/null 2>&1 ;
sudo rm -rfi ~/.psqlrc > /dev/null 2>&1 ;
sudo rm -rfi ~/.tigrc > /dev/null 2>&1 ;

#=============
# Cloning Repo
#=============
cd ~/Git && git clone --recursive https://github.com/VijayakumarRavi/Dotfiles.git ;

#==============
# Create symlinks in the home folder
# Allow overriding with files of matching names in the custom-configs dir
#==============
ln -sf $dotfiles_dir/nvim ~/.config/ ;
ln -sf $dotfiles_dir/htop ~/.config/ ;
ln -sf $dotfiles_dir/neofetch ~/.config/ ;
ln -sf $dotfiles_dir/zsh/ ~/.config/ ;
ln -sf $dotfiles_dir/tmux/ ~/.config/ ;

ln -sf $dotfiles_dir/.bashrc ~/.bashrc ;
ln -sf $dotfiles_dir/.conkyrc ~/.conkyrc ;
ln -sf $dotfiles_dir/.gitconfig ~/.gitconfig ;
ln -sf $dotfiles_dir/zsh/.zshrc ~/.zshrc ;


cd ~/Git && git clone https://aur.archlinux.org/yay.git && cd yay/ && makepkg -si --noconfirm ;

echo "${BPurple}   *****Brave-bin*****${NC}" ;
yay -S --noconfirm brave-bin ;

echo "${BPurple}   *****Google Chrome*****${NC}" ;
yay -S --noconfirm google-chrome ;

#=============
# ble.sh setup
#=============
cd ~/Git && git clone --recursive https://github.com/akinomyoga/ble.sh.git && make -C ble.sh install PREFIX=~/.local ;

#========
# fm6000
#========
curl https://raw.githubusercontent.com/anhsirk0/fetch-master-6000/master/fm6000.pl --output fm6000 && chmod +x fm6000 &&sudo mv fm6000 /usr/bin/ ;

sudo npm install -g neovim && sudo npm install --save nord && pip3 install pynvim ;

#=================
#Setting Wallpaper
#=================
sudo curl -L 'https://raw.githubusercontent.com/VijayakumarRavi/Wallpapers/main/From%20reddit.jpeg' --output /usr/share/backgrounds/gnome/wall.jpg && gsettings set org.gnome.desktop.background picture-uri '/usr/share/backgrounds/gnome/wall.jpg' && gsettings set org.gnome.desktop.screensaver picture-uri '/usr/share/backgrounds/gnome/wall.jpg' ;

#===================
#Nord Terminal Theme
#===================
cd ~/Git && git clone https://github.com/arcticicestudio/nord-gnome-terminal.git && cd nord-gnome-terminal/src && bash nord.sh -p vijay ;

cd ~/Git && curl -LO https://dllb2.pling.com/api/files/download/j/eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjE2MTkyMDU5NzUiLCJ1IjpudWxsLCJsdCI6ImRvd25sb2FkIiwicyI6ImRlODI4OTlmMTBmMWVhMzkxMmY2MWY2NDdiYTk2NjAyNzlkNzFiNDM4YWU3MmY3MTMxOTcyN2RkNGMwYzI2MjdjNjcyN2IyMjBlOWJiNWU2NjZiZGJiNDg0NDUwYmE4OWNlYmIyMTg0MjYwYWQ5MGE0OTg2MGM0NDFlNTgxZjEwIiwidCI6MTYyMDIzODY3Nywic3RmcCI6bnVsbCwic3RpcCI6bnVsbH0.S3ZRXnHZq65byxyoR0-U2bDD1WN_6cPMjFlvSf9yo4I/Nordic-darker.tar.xz && tar -xf Nordic-darker.tar.xz && sudo cp -vi Nordic-darker/   /usr/share/themes/ ;

# ---
# Install git-completion and git-prompt
# ---
cd ~/ && curl -OL https://github.com/git/git/raw/master/contrib/completion/git-completion.bash && mv ~/git-completion.bash ~/.git-completion.bash && curl https://raw.github.com/git/git/master/contrib/completion/git-prompt.sh -o ~/.git-prompt.sh ;

sudo sh ~/Git/Dotfiles/font.sh ;

sudo systemctl start firewalld && sudo firewall-cmd --add-port=1025-65535/tcp --permanent && sudo firewall-cmd --add-port=1025-65535/udp --permanent && sudo firewall-cmd --reload ;


#=========================================
# Give the user a finishing installed note
#=========================================
echo -e "\n\nApram ena ba!!\nNeeye pathukoo\nEllam adhu edathula vechachi\n"

