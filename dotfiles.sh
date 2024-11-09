#!/bin/bash
##### SETUP STEPS FOR BARE REPO ###################################################
# git init --bare ~/.dotfiles
# alias dotfiles='/usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"'
# dotfiles config --local status.showUntrackedFiles no
###################################################################################

#tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

YUM_CMD=$(which yum)
APT_GET_CMD=$(which apt-get)
PACMAN_GET_CMD=$(which pacman)
function get_package(){
	package=$1
	if [[ ! -z $YUM_CMD ]]; then
		sudo yum install $package
	elif [[ ! -z $APT_GET_CMD ]]; then
		sudo apt-get install $package
	elif [[ ! -z $PACMAN_GET_CMD ]]; then
		sudo pacman -Sy $package
# elif [[ ! -z $OTHER_CMD ]]; then
#    $OTHER_CMD <proper arguments>
	else
		echo "error can't install package $PACKAGE"
		exit 1;
	fi
}

get_package git
get_package vim
get_package tmux
get_package fzf
#tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
sleep 3
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
sleep 3
git clone --bare https://github.com/KalleNiemi/dotfiles.git $HOME/.dotfiles
sleep 2
alias dotfiles='/usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"'
sleep 1

## Overwrite exsisting
 /usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME" checkout -f

#mkdir -p .dotfiles-backup && \
#/usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | \
#xargs -I{} mv {} .dotfiles-backup/{}

/usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME" config --local status.showUntrackedFiles no

echo "alias dotfiles='/usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"'" >> ~/.bashrc
echo 'export EDITOR=vim' >> ~/.bashrc
echo "export FZF_DEFAULT_OPTS='--height 40% --tmux bottom,40% --layout reverse --border top'" >> ~/.bashrc
echo 'PS1="\[\e[0;32m\]\u\[\e[0;32m\]@\[\e[0;32m\]\h\[\e[0;37m\]:\[\e[0;34m\]\w\[\e[0;37m\]$ \[\e[0m\]"' >> ~./bashrc
