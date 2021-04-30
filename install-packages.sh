log_file=~/install_progress_log.txt

sudo pacman -S --noconfirm zsh
if type -p zsh > /dev/null; then
    echo "zsh Installed" >> $log_file
else
    echo "zsh FAILED TO INSTALL!!!" >> $log_file
fi

sudo pacman -S --noconfirm zsh-syntax-highlighting

sudo pacman -S --noconfirm neovim
if type -p nvim > /dev/null; then
    echo "Neovim Installed" >> $log_file
else
    echo "Neovim FAILED TO INSTALL!!!" >> $log_file
fi

sudo pacman -S --noconfirm curl
if type -p curl > /dev/null; then
    echo "curl Installed" >> $log_file
else
    echo "crul FAILED TO INSTALL!!!" >> $log_file
fi

sudo pacman -S --noconfirm telegram-desktop
if type -p telegram-desktop > /dev/null; then
    echo "telegram-desktop Installed" >> $log_file
else
    echo "telegram-desktop FAILED TO INSTALL!!!" >> $log_file
fi

sudo pacman -S --noconfirm thunderbird
if type -p thunderbird > /dev/null; then
    echo "thunderbird Installed" >> $log_file
else
    echo "thunderbird FAILED TO INSTALL!!!" >> $log_file
fi

sudo pacman -S --noconfirm gnome-tweaks
if type -p gnome-tweaks > /dev/null; then
    echo "gnome-tweaks Installed" >> $log_file
else
    echo "gnome-tweaks FAILED TO INSTALL!!!" >> $log_file
fi

yay -S --noconfirm google-chrome
if type -p google-chrome-stable > /dev/null; then
    echo "google-chrome Installed" >> $log_file
else
    echo "google-chrome FAILED TO INSTALL!!!" >> $log_file
fi

yay -S --noconfirm brave-bin
if type -p brave > /dev/null; then
    echo "brave-bin Installed" >> $log_file
else
    echo "brave-bin FAILED TO INSTALL!!!" >> $log_file
fi

sudo pacman -S --noconfirm conky
if type -p conky > /dev/null; then
    echo "conky Installed" >> $log_file
else
    echo "conky FAILED TO INSTALL!!!" >> $log_file
fi

sudo pacman -S --noconfirm htop
if type -p htop > /dev/null; then
    echo "htop Installed" >> $log_file
else
    echo "htop FAILED TO INSTALL!!!" >> $log_file
fi

sudo pacman -S --noconfirm neofetch
if type -p neofetch > /dev/null; then
    echo "neofetch Installed" >> $log_file
else
    echo "neofetch FAILED TO INSTALL!!!" >> $log_file
fi

# ---
# Install git-completion and git-prompt
# ---
cd ~/
curl -OL https://github.com/git/git/raw/master/contrib/completion/git-completion.bash
mv ~/git-completion.bash ~/.git-completion.bash
curl https://raw.github.com/git/git/master/contrib/completion/git-prompt.sh -o ~/.git-prompt.sh
echo "git-completion and git-prompt Installed and Configured" >> $log_file

# ---
# Install node
# ---
cd ~/
git clone https://github.com/joyent/node
cd node
sudo ./configure --prefix=/usr/local
sudo make
sudo make install
cd ~/
sudo rm -r node # Remove the node folder in the home directory

# node it seems is installed as nodejs in Mint if that
# is the case we create a symlink to node
if [[ (! -f /usr/bin/node) && (-f /usr/bin/nodejs) ]]; then
    sudo ln -s /usr/bin/nodejs /usr/bin/node
fi

if type -p node > /dev/null; then
    echo -n "Node version: "; echo -n `node --version`; echo " Installed" >> $log_file
else
    echo "node FAILED TO INSTALL!!!" >> $log_file
fi

sudo pacman -S --noconfirm npm
if type -p npm > /dev/null; then
    echo "npm Installed" >> $log_file
else
    echo "npm FAILED TO INSTALL!!!" >> $log_file
fi

sudo pacman -S --noconfirm python3-pip
if type -p pip3 > /dev/null; then
    echo "pip3 Installed" >> $log_file
else
    echo "pip3 FAILED TO INSTALL!!!" >> $log_file
fi

sudo pacman -S --noconfirm tmux
if type -p tmux > /dev/null; then
    echo "tmux Installed" >> $log_file
else
    echo "tmux FAILED TO INSTALL!!!" >> $log_file
fi


#==============
# Give the user a summary of what has been installed
#==============
echo -e "\n====== Summary ======\n"
cat $log_file
echo
echo -e "\n\nApram ena ba!!\nNeeye pathukoo\nVantha ellam install pannitan ba\n"
rm $log_file
