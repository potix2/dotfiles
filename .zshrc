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

# aliases
alias ls='ls -G -w'
alias vspec='vspec . $HOME/.vim/'
alias v='vim'

# aliases for git
alias g='git'
alias ga='git add'
alias gst='git status'
alias gdi='git diff'
alias gci='git commit -a'

# aliases for tmux
alias t='tmux'
alias ta='tmux attach'

# aliases for zsh
alias ze='v ~/.zshrc'
alias zel='v ~/.local.zshrc'
alias zs='source ~/.zshrc'
alias zsl='source ~/.local.zshrc'

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

#for php
export PHP_HOME=$HOME/local/php/versions
export PHP_VERSIONS=$HOME/local/php/versions
[ -f $(brew --prefix php-version)/php-version.sh ] &&
    source $(brew --prefix php-version)/php-version.sh && php-version 5.4.0 > /dev/null

#setup path
if [ -d $HOME/bin ]; then
    PATH=$HOME/bin:$PATH
fi

if [ -d $HOME/.cabal/bin ]; then
    PATH=$HOME/.cabal/bin:$PATH
fi

if [ -d /usr/local/bin ]; then
    PATH=/usr/local/bin:$PATH
fi

if [ -d /usr/local/sbin ]; then
    PATH=/usr/local/sbin:$PATH
fi
[ -z "$path" ] && typeset -T PATH path
typeset -U path
