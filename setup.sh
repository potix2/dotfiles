#!/bin/sh

WSDIR=$(cd $(dirname $0); pwd)
ln -nsf ${WSDIR}/.vimrc $HOME/.vimrc
ln -nsf ${WSDIR}/.zshrc $HOME/.zshrc
ln -nsf ${WSDIR}/.tmux.conf $HOME/.tmux.conf
ln -nsf ${WSDIR}/.gitconfig $HOME/.gitconfig
