#!/bin/sh

WSDIR="$HOME/dotfiles"
if [ ! -d "$HOME/dotfiles" ];
then
    git clone git@github.com:potix2/dotfiles.git
fi

if [ ! -d "$HOME/zsh-completions" ];
then
    git clone git@github.com:potix2/zsh-completions.git
fi

# make links

ln -nsf ${WSDIR}/.vimrc $HOME/.vimrc
ln -nsf ${WSDIR}/.zshrc $HOME/.zshrc
ln -nsf ${WSDIR}/.tmux.conf $HOME/.tmux.conf
ln -nsf ${WSDIR}/.gitconfig $HOME/.gitconfig
ln -nsf ${HOME}/zsh-completions/src $HOME/.zsh.d

if [ ! -d $HOME/.vim/autoload ];
then
    mkdir -p $HOME/.vim/autoload ~/.vim/bundle
    curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
fi

if [ ! -d $HOME/.vim/bundle/vundle ];
then
    git clone https://github.com/gmarik/vundle.git $HOME/.vim/bundle/vundle
fi
