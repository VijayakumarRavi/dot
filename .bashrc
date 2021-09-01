# Syntax highlighting ble.sh
[[ $- == *i* ]] &&
  source "$HOME/.local/share/blesh/ble.sh" --attach=none

#auto cd
shopt -s autocd
shopt -s cdspell
shopt -s cdable_vars
shopt -s expand_aliases
# vim mode
set -o vi

export VISUAL="/usr/bin/nvim"
export EDITOR="$VISUAL"

#neofetch
echo -e "\e[0;33mVanakkam da Mapla\e[0;31m\e[0;32m \n"
#echo -e "\e[38;5;45mUNIX IS VERY SIMPLE \e[1;92mIT JUST NEEDS A\nGENIUS TO UNDERSTAND ITS SIMPLICITY\n 		\e[38;5;45m-By Dennis Ritchie\e[m"
date
function _exit()              # Function to run upon exit of shell.
{
    echo -e "\e[0;31mPoittu varan da Iyyasammi!!!\e[m"
}
trap _exit EXIT

PROMPTS=("∮" "∯" "≎" "" "" "" "" "" "" "" "")

RANDOM_PROMPTS() {
  SELECTED_EMOJI=${PROMPTS[$RANDOM % ${#PROMPTS[@]}]};
  echo $SELECTED_EMOJI;
}
# $(RANDOM_PROMPTS)

PS1="\[\033[32m\]\w\n\e[0;38m[\e[0;35m\u\e[1;36m@\e[0;38m\h\e[0;35m]\e[1;36m ∮ \[\033[0m\]"
#PS1="\n🍎\e[0;34m \033[1m$(ifconfig $(route -n | grep ^0.0.0.0 | awk '{print $NF}') | grep inet | grep -v inet6 | awk '{print $2}') : \033[0m"

# System Aliases
alias rm='rm -vr'
alias cp='cp -vr'
alias mv='mv -v'
alias mkdir='mkdir -pv'
alias SS='doas systemctl'
alias ls='ls -hAN --color=auto --group-directories-first'
alias ll='ls -lAv --color=auto --group-directories-first'
alias grep='grep --color=auto'
alias h='history'
alias j='jobs -l'
alias which='type -a'
alias du='du -kh'    # Makes a more readable output.
alias df='df -kTh'

# For ease of use shortcuts
alias q='exit'
alias :q='exit'
alias c='clear'
alias r='ranger'
alias ..='cd ..'
alias ...='cd ..; cd ..'
alias n='nvim'
alias sn='sudo nvim'
alias vim='nvim'

# Edit congfis
alias nrc='nvim ~/.config/nvim/init.lua'
alias bashrc='nvim ~/.bashrc'
alias i3con='nvim ~/.config/i3/config'
alias loadbash='source ~/.bashrc'
alias notes='nvim ~/.notes.txt'

alias p='doas pacman'
alias y='yay'
alias orphan='doas pacman -Rs $(pacman -Qqtd)' # Removes orphan packages
alias mirrorlist='doas reflector -a 6 -c IN --save /etc/pacman.d/mirrorlist'

alias w='/home/vijay/git/dot/.config/unsplash.sh'

# Git
alias gs='git status'
alias gc='git clone --depth=1'

git_auto() {
	add=$1
	com=$2
	echo "Add-file: " $add
	echo "Comm-msg: " $com
	sleep 2
	git add $add
	git commit -m "$com"
	git push origin
	printf "\e[1;32m\n\nPending files \n\n\e[0m"
	printf "\e[1;35m"
	git ls-files -m
}

# youtube-dl
alias yta='youtube-dl --extract-audio --audio-format best'
alias ytv='youtube-dl -f bestvideo+bestaudio '
alias ytap="youtube-dl --extract-audio --audio-format mp3 -o '%(playlist)s/%(playlist_index)s - %(title)s.%(ext)s' "
alias ytvp="youtube-dl -o '%(playlist)s/%(playlist_index)s - %(title)s.%(ext)s' "

# Handy Extract Program
function extract()
{
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xvjf $1     ;;
            *.tar.gz)    tar xvzf $1     ;;
            *.bz2)       bunzip2 $1      ;;
            *.rar)       unrar x $1      ;;
            *.gz)        gunzip $1       ;;
            *.tar)       tar xvf $1      ;;
            *.tbz2)      tar xvjf $1     ;;
            *.tgz)       tar xvzf $1     ;;
            *.zip)       unzip $1        ;;
            *.Z)         uncompress $1   ;;
            *.7z)        7z x $1         ;;
            *)           echo "'$1' cannot be extracted via >extract<" ;;
        esac
    else
        echo "'$1' is not a valid file!"
    fi
}

# install Aur packages
aur(){ curl  -O https://aur.archlinux.org/cgit/aur.git/snapshot/$1.tar.gz && tar -xvf $1.tar.gz && cd $1 && makepkg --noconfirm -si && cd .. && rm -rf $1 $1.tar.gz ;}
# syntax highlighting
((_ble_bash)) && ble-attach

# alias luamake=/home/vijay/git/lua-language-server/3rd/luamake/luamake
. "$HOME/.cargo/env"
