DISTRO=$( cat /etc/*-release | tr [:upper:] [:lower:] | grep -Poi '(debian|ubuntu|red hat|centos|arch)' | uniq
if [$DISTRO=="arch"]; then
	echo "Arch based distro found !!!!!"
	sudo pacman -S --noconfirm zsh
	sudo pacman -S --noconfirm zsh-syntax-highlighting
	sudo pacman -S --noconfirm neovim
	sudo pacman -S --noconfirm curl
	sudo pacman -S --noconfirm telegram-desktop
	sudo pacman -S --noconfirm thunderbird
	sudo pacman -S --noconfirm gnome-tweaks
	yay -S --noconfirm google-chrome
	yay -S --noconfirm brave-bin
	sudo pacman -S --noconfirm conky
	sudo pacman -S --noconfirm htop
	sudo pacman -S --noconfirm neofetch
	sudo pacman -S --noconfirm npm
	sudo pacman -S --noconfirm python-pip
	sudo pacman -S --noconfirm tmux
fi

if [$DISTRO=="debian"]; then
	echo "Debian based distro found !!!!"
	sudo apt install -y zsh
	sudo apt install -y zsh-syntax-highlighting
	sudo apt install -y neovim
	sudo apt install -y curl
	sudo apt install -y telegram-desktop
	sudo apt install -y thunderbird
	sudo apt install -y gnome-tweaks
	echo "Downloading chrome package!!!"
	wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
	sudo apt install ./google-chrome-stable_current_amd64.deb

	echo "Installing Beave"
	sudo apt install apt-transport-https curl
	sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
	echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
	sudo apt update
	sudo apt install brave-browser

	sudo apt install -y conky
	sudo apt install -y htop
	sudo apt install -y neofetch
	sudo apt install -y npm
	sudo apt install -y python-pip
	sudo apt install -y tmux
else
	echo -e "Something Wrong !!!!!!\n\n $DISTRO \n\n"
fi

# ---
# Install git-completion and git-prompt
# ---
cd ~/
curl -OL https://github.com/git/git/raw/master/contrib/completion/git-completion.bash
mv ~/git-completion.bash ~/.git-completion.bash
curl https://raw.github.com/git/git/master/contrib/completion/git-prompt.sh -o ~/.git-prompt.sh
# ---
# Cloning Repo
# ---
mkdir ~/Git
cd ~/Git
git clone https://github.com/VijayakumarRavi/Dotfiles.git

#==============
# Variables
#==============
dotfiles_dir=~/Git/Dotfiles

#==============
# Delete existing dot files and folders
#==============
sudo rm -rif ~/.vim > /dev/null 2>&1
sudo rm -rfi ~/.vimrc > /dev/null 2>&1
sudo rm -rfi ~/.bashrc > /dev/null 2>&1
sudo rm -rfi ~/.tmux > /dev/null 2>&1
sudo rm -rfi ~/.tmux.conf > /dev/null 2>&1
sudo rm -rfi ~/.zsh_prompt > /dev/null 2>&1
sudo rm -rfi ~/.zshrc > /dev/null 2>&1
sudo rm -rfi ~/.gitconfig > /dev/null 2>&1
sudo rm -rfi ~/.antigen > /dev/null 2>&1
sudo rm -rfi ~/.antigen.zsh > /dev/null 2>&1
sudo rm -rfi ~/.psqlrc > /dev/null 2>&1
sudo rm -rfi ~/.tigrc > /dev/null 2>&1

#==============
# Create symlinks in the home folder
# Allow overriding with files of matching names in the custom-configs dir
#==============
ln -sf $dotfiles_dir/nvim ~/.config/
ln -sf $dotfiles_dir/htop ~/.config/
ln -sf $dotfiles_dir/neofetch ~/.config/
ln -sf $dotfiles_dir/zsh/ ~/.config/

ln -sf $dotfiles_dir/.bashrc ~/.bashrc
ln -sf $dotfiles_dir/.conkyrc ~/.conkyrc
ln -s $dotfiles_dir/.gitconfig ~/.gitconfig
ln -s $dotfiles_dir/zsh/.zshrc ~/.zshrc


#==============
# Set zsh as the default shell
#==============
# sudo chsh -s /bin/zsh

#==============
# Give the user a finishing installed note
#==============
echo -e "\n\nApram ena ba!!\nNeeye pathukoo\nEllam adhu edathula vechachi\n"
