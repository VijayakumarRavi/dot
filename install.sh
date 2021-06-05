#!/bin/bash

# printf "\e[1;32m*********Dotfiles Scripts Started**********/n\e[0m"
#==============
# Variables
#==============
HOME=/home/vijay
dotfiles_dir=/home/vijay/Git/Dotfiles
BPurple='\e[1;35m'
NC="\e[m"
create-dirs() {
if [[ ! -d $HOME/Git ]]; then
	mkdir -p $HOME/Git ;
	echo "Git folder is created" ;
else
	echo "Git is already exist" ;
fi

if [[ ! -d $HOME/.config ]]; then
	mkdir $HOME/.config ;
	echo ".config folder is created" ;
else
	echo ".config already exist" ;
fi
}

del-existing-files() {
	rm -rvif $HOME/.vim > /dev/null 2>&1 ;
	rm -rvfi $HOME/.vimrc > /dev/null 2>&1 ;
	rm -rvfi $HOME/.bashrc > /dev/null 2>&1 ;
	rm -rvfi $HOME/.tmux > /dev/null 2>&1 ;
	rm -rvfi $HOME/.tmux.conf > /dev/null 2>&1 ;
	rm -rvfi $HOME/.zsh_prompt > /dev/null 2>&1 ;
	rm -rvfi $HOME/.zshrc > /dev/null 2>&1 ;
	rm -rvfi $HOME/.gitconfig > /dev/null 2>&1 ;
	rm -rvfi $HOME/.antigen > /dev/null 2>&1 ;
	rm -rvfi $HOME/.antigen.zsh > /dev/null 2>&1 ;
	rm -rvfi $HOME/.psqlrc > /dev/null 2>&1 ;
	rm -rvfi $HOME/.tigrc > /dev/null 2>&1 ;
}

cloneing-repos(){
	cd $HOME/Git/
	git clone --recursive https://github.com/VijayakumarRavi/Dotfiles.git ;
	git clone --recursive https://github.com/akinomyoga/ble.sh.git ;
}

link-files() {
	ln -svf $dotfiles_dir/pacman.conf /etc/ ;
	ln -svf $dotfiles_dir/nvim $HOME/.config/ ;
	ln -svf $dotfiles_dir/htop $HOME/.config/ ;
	ln -svf $dotfiles_dir/neofetch $HOME/.config/ ;
	ln -svf $dotfiles_dir/zsh/ $HOME/.config/ ;
	ln -svf $dotfiles_dir/tmux/ $HOME/.config/ ;
	ln -svf $dotfiles_dir/.bashrc $HOME/.bashrc ;
	ln -svf $dotfiles_dir/.conkyrc $HOME/.conkyrc ;
	ln -svf $dotfiles_dir/.gitconfig $HOME/.gitconfig ;
	ln -svf $dotfiles_dir/zsh/.zshrc $HOME/.zshrc ;
}

repo-install() {
	cd $HOME/Git
	make -C ble.sh install PREFIX=$HOME/.local ;
}

others() {
	cd $HOME/Git
	curl https://raw.githubusercontent.com/anhsirk0/fetch-master-6000/master/fm6000.pl --output fm6000 && chmod +x fm6000 && sudo mv fm6000 /usr/bin/ ;
	npm install -g neovim ;
	npm install --save nord ;
	pip3 install pynvim ;
	curl -L https://github.com/git/git/raw/master/contrib/completion/git-completion.bash -o $HOME/.git-completion.bash ;
	curl -L https://raw.github.com/git/git/master/contrib/completion/git-prompt.sh -o $HOME/.git-prompt.sh ;
}

grub-theme() {
	cd $dotfiles_dir/themes
	bash install.sh ;
}

create-dirs
del-existing-files
cloneing-repos
link-files
repo-install
grub-theme
others

echo -e "\n\nApram ena ba!!\nNeeye pathukoo\nEllam adhu edathula vechachi\n"

