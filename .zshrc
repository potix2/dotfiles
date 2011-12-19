autoload colors
colors
setopt auto_pushd
setopt noautoremoveslash
bindkey -e
autoload -U compinit
compinit
PROMPT='%39<...<%/%% '
PROMPT2="%_%% "
SPROMPT="%r is correct? [n,y,a,e]: "

export LSCOLORS=dxfxcxdxbxegedabagacad

alias ls='ls -G -w'
alias la='ls -a'
alias lf='ls -F'
alias ll='ls -l'
alias f='open'
alias github='open https://github.com'
alias gist='open https://gist.github.com/mine'
alias screen=/usr/local/bin/screen

if [ -f $HOME/.local.zshrc ]; then
    source $HOME/.local.zshrc
fi
