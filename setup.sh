#!/bin/sh

WSDIR="$HOME/dotfiles"
if [ ! -d "$HOME/dotfiles" ];
then
    git clone git@github.com:potix2/dotfiles.git ~/dotfiles
fi

if [ ! -d "$HOME/zsh-completions" ];
then
    git clone git@github.com:potix2/zsh-completions.git ~/zsh-completions
fi

# make links

ln -nsf ${WSDIR}/.vimrc $HOME/.vimrc
ln -nsf ${WSDIR}/.zshrc $HOME/.zshrc
ln -nsf ${WSDIR}/.ideavimrc $HOME/.ideavimrc
ln -nsf ${WSDIR}/.tmux.conf $HOME/.tmux.conf
ln -nsf ${WSDIR}/.gitconfig $HOME/.gitconfig
ln -nsf ${HOME}/zsh-completions/src $HOME/.zsh.d

if [ ! -d "${HOME}/.vim/pack/minpac/opt/minpac" ];
then
    echo "check"
    git clone https://github.com/k-takata/minpac.git \
        ~/.vim/pack/minpac/opt/minpac
fi

# setup goenv
if [ ! -d "$HOME/.goenv" ];
then
    git clone https://github.com/syndbg/goenv.git ~/.goenv
fi

# setup gh
if ! [ -x "$(command -v gh)" ];
then
    sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-key C99B11DEB97541F0
    sudo apt-add-repository https://cli.github.com/packages
    sudo apt update
    sudo apt install gh
    gh completion -s zsh > ~/.zsh.d/_gh
fi
