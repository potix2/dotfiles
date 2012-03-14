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

if [ -x "`which open 2> /dev/null`" ]; then
    alias github='open https://github.com'
    alias gist='open https://gist.github.com/mine'
fi

if [ -f /usr/local/bin/screen ]; then
    alias screen=/usr/local/bin/screen
fi

if [ ! -d $HOME/.screen ]; then
    mkdir -m 700 $HOME/.screen
fi
export SCREENDIR="$HOME/.screen"

if [ -f $HOME/.local.zshrc ]; then
    source $HOME/.local.zshrc
fi

function lw2lu {
    nkf -Lu $1 > $1.tmp
    mv $1.tmp $1
}

function lu2lw {
    nkf -Lw $1 > $1.tmp
    mv $1.tmp $1
}
