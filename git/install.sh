#!/bin/bash

# printf "\e[1;32m*********Dotfiles Scripts Started**********/n\e[0m"
#==============
# Variables
#==============
HOME=/home/vijay
dotfiles_dir=/home/vijay/git/dot/.config
BPurple='\e[1;35m'
NC="\e[m"

create-dirs() {
if [[ ! -d $HOME/git ]]; then
	mkdir -p $HOME/git ;
	echo "git folder is created" ;
else
	echo "git is already exist" ;
fi

if [[ ! -d $HOME/.config ]]; then
	mkdir $HOME/.config ;
	echo ".config folder is created" ;
else
	echo ".config already exist" ;
fi
}

cloneing-repos(){
	git clone --recursive https://github.com/VijayakumarRavi/dot.git $HOME/git/dot/ && \
	git clone --recursive https://github.com/akinomyoga/ble.sh.git $HOME/git/ble.sh/ && \
	make -C $HOME/git/ble.sh install PREFIX=$HOME/.local ;
}

link-files() {
	sudo ln -svf $dotfiles_dir/pacman.conf /etc/ && \
	ln -svf $dotfiles_dir/alacritty $HOME/.config/ && \
	ln -svf $dotfiles_dir/awesome $HOME/.config/ && \
	ln -svf $dotfiles_dir/dunst $HOME/.config/ && \
	ln -svf $dotfiles_dir/htop $HOME/.config/ && \
	ln -svf $dotfiles_dir/i3 $HOME/.config/ && \
	ln -svf $dotfiles_dir/neofetch $HOME/.config/ && \
	ln -svf $dotfiles_dir/nvim $HOME/.config/ && \
	ln -svf $dotfiles_dir/pcmanfm $HOME/.config/ && \
	ln -svf $dotfiles_dir/picom $HOME/.config/ && \
	ln -svf $dotfiles_dir/polybar $HOME/.config/ && \
	ln -svf $dotfiles_dir/ranger $HOME/.config/ && \
	ln -svf $dotfiles_dir/rofi $HOME/.config/ && \
	ln -svf $dotfiles_dir/tmux $HOME/.config/ && \
	ln -svf $dotfiles_dir/transmission $HOME/.config/ && \
	ln -svf $dotfiles_dir/x11 $HOME/.config/ && \
	ln -svf $dotfiles_dir/zsh $HOME/.config/ && \
	ln -svf $dotfiles_dir/zsh/.zshrc $HOME/.zshrc && \
	ln -svf $dotfiles_dir/.conkyrc $HOME/.conkyrc && \
	ln -svf $dotfiles_dir/.gitconfig $HOME/.gitconfig && \
	ln -svf /home/vijay/git/dot/.bashrc $HOME/.bashrc && \
	ln -svf /home/vijay/git/dot/.inputrc $HOME/.inputrc ;
}

others-settings() {
	cd $HOME/git
	curl https://raw.githubusercontent.com/anhsirk0/fetch-master-6000/master/fm6000.pl --output fm6000 && chmod +x fm6000 && sudo mv fm6000 /usr/bin/ && \
	sudo npm install -g neovim && \
	sudo npm install --save nord && \
	pip3 install pynvim && \
	curl -L https://github.com/git/git/raw/master/contrib/completion/git-completion.bash -o $HOME/.git-completion.bash && \
	curl -L https://raw.github.com/git/git/master/contrib/completion/git-prompt.sh -o $HOME/.git-prompt.sh ;
}

create-dirs
cloneing-repos
link-files
others-settings

echo -e "\n\nApram ena ba!!\nNeeye pathukoo\nEllam adhu edathula vechachi\n"

