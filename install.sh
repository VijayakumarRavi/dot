DISTRO=$( cat /etc/*-release | tr [:upper:] [:lower:] | grep -Poi '(debian|ubuntu|red hat|centos|arch)' | uniq)

BPurple='\e[1;35m'
NC="\e[m"

echo "${BPurple}   *****Pacman*****${NC}"
# echo "Arch based distro found !!!!!"

echo "${BPurple}   *****Zsh*****${NC}"
sudo pacman -S --noconfirm zsh

echo "${BPurple}   *****Git*****${NC}"
sudo pacman -S --noconfirm git

echo "${BPurple}   ***** zsh-syntax-highlighting *****${NC}"
sudo pacman -S --noconfirm zsh-syntax-highlighting

echo "${BPurple}   *****Neovim*****${NC}"
sudo pacman -S --noconfirm neovim

echo "${BPurple}   *****curl*****${NC}"
sudo pacman -S --noconfirm curl

echo "${BPurple}   *****Telegram*****${NC}"
sudo pacman -S --noconfirm telegram-desktop

echo "${BPurple}   *****Thunderbird*****${NC}"
sudo pacman -S --noconfirm thunderbird

echo "${BPurple}   *****Gnome Tweaks*****${NC}"
sudo pacman -S --noconfirm gnome-tweaks

echo "${BPurple}   *****Google Chrome*****${NC}"
yay -S --noconfirm google-chrome

echo "${BPurple}   *****Brave*****${NC}"
yay -S --noconfirm brave-bin

echo "${BPurple}   *****conky*****${NC}"
sudo pacman -S --noconfirm conky

echo "${BPurple}   *****Htop*****${NC}"
sudo pacman -S --noconfirm htop

echo "${BPurple}   *****Neofetch*****${NC}"
sudo pacman -S --noconfirm neofetch

echo "${BPurple}   *****Npm*****${NC}"
sudo pacman -S --noconfirm npm

echo "${BPurple}   *****Python pip*****${NC}"
sudo pacman -S --noconfirm python-pip

echo "${BPurple}   *****tmux*****${NC}"
sudo pacman -S --noconfirm tmux

echo "${BPurple}   *****gawk*****${NC}"
sudo pacman -S --noconfirm gawk

echo "${BPurple}   *****Cowsay*****${NC}"
sudo pacman -S --noconfirm cowsay

echo "${BPurple}   *****Fortune*****${NC}"
sudo pacman -S --noconfirm fortune-mod

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
mkdir ~/.config
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
ln -sf $dotfiles_dir/tmux/ ~/.config/

ln -sf $dotfiles_dir/.bashrc ~/.bashrc
ln -sf $dotfiles_dir/.conkyrc ~/.conkyrc
ln -s $dotfiles_dir/.gitconfig ~/.gitconfig
ln -s $dotfiles_dir/zsh/.zshrc ~/.zshrc


#==============
# Set zsh as the default shell
#==============
sudo chsh -s /bin/zsh

#===============
# Starting conky
#===============
conky -c ~/.conkyrc &

#=============
# ble.sh setup
#=============
cd ~/Git
git clone --recursive https://github.com/akinomyoga/ble.sh.git
make -C ble.sh install PREFIX=~/.local

#========
# fm6000
#========
curl https://raw.githubusercontent.com/anhsirk0/fetch-master-6000/master/fm6000.pl --output fm6000
chmod +x fm6000
sudo mv fm6000 /usr/bin/

sudo npm install -g neovim
pip3 install pynvim

#=========================================
# Give the user a finishing installed note
#=========================================
echo -e "\n\nApram ena ba!!\nNeeye pathukoo\nEllam adhu edathula vechachi\n"


#=================
#Setting Wallpaper
#=================
sudo curl -L 'https://raw.githubusercontent.com/VijayakumarRavi/Wallpapers/main/From%20reddit.jpeg' --output /usr/share/backgrounds/gnome/wall.jpg
gsettings set org.gnome.desktop.background picture-uri '/usr/share/backgrounds/gnome/wall.jpg'
gsettings set org.gnome.desktop.screensaver picture-uri '/usr/share/backgrounds/gnome/wall.jpg'

