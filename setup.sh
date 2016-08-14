#!/bin/sh

WSDIR=$(cd $(dirname $0); pwd)
ln -nsf ${WSDIR}/.vimrc $HOME/.vimrc
ln -nsf ${WSDIR}/.zshrc $HOME/.zshrc
ln -nsf ${WSDIR}/.tmux.conf $HOME/.tmux.conf
ln -nsf ${WSDIR}/.gitconfig $HOME/.gitconfig
ln -nsf ${HOME}/ws/zsh-completions/src $HOME/.zsh.d

if [ ! -d $HOME/.vim/bundle/vundle ];
then
    git clone https://github.com/gmarik/vundle.git $HOME/.vim/bundle/vundle
fi
