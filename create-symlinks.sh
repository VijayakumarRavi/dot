#!/bin/zsh
#===============================================================================
#
#             NOTES: For this to work you must have cloned the github
#                    repo to your home folder as ~/dotfiles/
#
#===============================================================================

#==============
# Variables
#==============
dotfiles_dir=~/Git/Dotfiles
log_file=~/install_progress_log.txt

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
# Give the user a summary of what has been installed
#==============
echo -e "\n====== Summary ======\n"
cat $log_file
echo
echo -e "\n\nApram ena ba!!\nNeeye pathukoo\nEllam adhu edathula vechachi\n"
rm $log_file
