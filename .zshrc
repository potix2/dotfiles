autoload colors
colors
setopt auto_pushd
setopt noautoremoveslash
setopt prompt_subst
autoload -U compinit
autoload -Uz vcs_info
bindkey -e
compinit
#PROMPT='%39<...<%/%% '
#PROMPT=$'%{\e[$[32]m%}$USER@%m%%%{\e[m%}%u '
PROMPT=$'%{[$[36]m%}%U$USER@'"%m%{[m%}%%%u "
PROMPT2="%_%% "
SPROMPT="%r is correct? [n,y,a,e]: "

export LSCOLORS=dxfxcxdxbxegedabagacad
alias ls='ls -G -w'
alias vspec='vspec . $HOME/.vim/'

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

zstyle 'vcs_info:*' formats '[%b]'
zstyle 'vcs_info:*' actionformats '[%b|%a]'
precmd() {
    psvar={}
    LANG=ja_JP.UTF-8 vcs_info
    [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}

RPROMPT="[%~] %1(v|%F{green}%1v%f|)"
