autoload colors
colors

#setup script path
typeset -U fpath
fpath=($fpath ~/.zsh.d)

setopt auto_pushd
setopt noautoremoveslash
setopt prompt_subst
autoload -U compinit
autoload -Uz vcs_info
bindkey -e
compinit
PROMPT=$'%{[$[36]m%}%U$USER@'"%m%{[m%}%%%u "
PROMPT2="%_%% "
SPROMPT="%r is correct? [n,y,a,e]: "

# config history
HISTFILE=$HOME/.zsh-history
HISTSIZE=100000
SAVEHIST=100000
setopt extended_history
setopt share_history
function history-all { history -E 1 }

# setup env
export LSCOLORS=dxfxcxdxbxegedabagacad

# aliases
alias ls='ls -G'
alias v='vim'

# aliases for git
alias g='git'
alias ga='git add'
alias gst='git status'
alias gbr='git branch'
alias gdi='git diff --color'
alias gds='git diff --color --staged'
alias gci='git commit -a'
alias gco='git checkout'
alias glgg='git log --color --graph --decorate --oneline'
alias glgs='git log --stat --color'

# aliases for gradle
alias gr='gradle'
alias grb='gradle build'
alias grc='gradle clean'

# aliases for bundle
alias b='bundle'
alias bi='bundle install'
alias be='bundle exec'
alias br='bundle exec rake'
alias brs='bundle exec rspec'

# aliases for rake
alias rdm='rake db:migrate'
alias rdrm='rake db:migrate:reset db:migrate'
alias rds='rake db:seed'

# aliases for tmux
alias t='tmux'
alias ta='tmux attach'

# aliases for zsh
alias ze='v ~/.zshrc'
alias zel='v ~/.local.zshrc'
alias zs='source ~/.zshrc'
alias zsl='source ~/.local.zshrc'

alias pink='ping'

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

function lessmd {
    grip $1 --export /dev/stdout | w3m -T text/html
}

zstyle 'vcs_info:*' formats '[%b]'
zstyle 'vcs_info:*' actionformats '[%b|%a]'
precmd() {
    psvar={}
    LANG=ja_JP.UTF-8 vcs_info
    [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}

RPROMPT="[%~] %1(v|%F{green}%1v%f|)"

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

if [ -d ${HOME}/.rbenv ]; then
    PATH=${HOME}/.rbenv/bin:${PATH}
    eval "$(rbenv init -)"
fi

[ -f /opt/boxen/env.sh ] && source /opt/boxen/env.sh
if [ -d ${HOME}/.nodebrew ]; then
    PATH=${HOME}/.nodebrew/current/bin:${PATH}
fi

export GOROOT=/usr/local/Cellar/go/1.2.2
export GOPATH=/usr/local/bin/go


function peco-select-history() {
   local tac
   if which tac > /dev/null; then
       tac="tac"
   else
       tac="tail -r"
   fi
   BUFFER=$(\history -n 1 | \
       eval $tac | \
       peco --query "$LBUFFER")
   CURSOR=$#BUFFER
   zle clear-screen
}
zle -N peco-select-history
bindkey '^r' peco-select-history

[ -z "$path" ] && typeset -T PATH path
typeset -U path
