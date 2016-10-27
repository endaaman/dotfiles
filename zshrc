

local dirname="%F{cyan}%~%f"

if [ -n "$container" ]; then
  local pre_prompt="[%F{green}LXC%f]"
fi

if [ -n "$SSH_CLIENT" ]; then
  local pre_prompt="(%F{green}SSH%f:%F{magenta}$(hostname)%f)"
fi

if [ ${EUID:-${UID}} = 0 ]; then
  local prompt_symbol='#'
else
  local prompt_symbol='$'
fi
local prompt_symbol="%(?.%F{yellow}.%F{magenta})$prompt_symbol%f"

PROMPT="$pre_prompt$dirname $prompt_symbol "


if [ -d ~/.zplug ]; then
  source ~/.zplug/init.zsh
  zplug "olivierverdier/zsh-git-prompt", use:"zshrc.sh"
  zplug "zsh-users/zsh-completions"

  if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
      echo; zplug install
    fi
  fi
  zplug load
  RPROMPT='$(git_super_status)'
fi


autoload -Uz colors; colors
autoload -Uz compinit; compinit
autoload -Uz promptinit; promptinit
autoload -Uz add-zsh-hock
autoload -Uz chpwd_recent_dirs
autoload -Uz add-zsh-hook
autoload -Uz cdr

eval `dircolors -b`

zstyle ':completion:*' list-colors $LS_COLORS
zstyle ':completion:*' ignore-parents parent pwd ..
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'

# disable C-q C-s
stty stop undef
stty start undef

DIRSTACKSIZE=100
HISTSIZE=100000
SAVEHIST=100000

setopt AUTO_PUSHD
setopt hist_ignore_dups
setopt share_history
setopt hist_ignore_space

zstyle ':completion:*' menu select
zstyle ':completion:*:cd:*' ignore-parents parent pwd
zstyle ':completion:*:descriptions' format '%BCompleting%b %U%d%u'


mkdir -p $HOME/.cache/shell/

zstyle ':completion:*' recent-dirs-insert both
zstyle ':chpwd:*' recent-dirs-max 500
zstyle ':chpwd:*' recent-dirs-default true
zstyle ':chpwd:*' recent-dirs-file "$HOME/.cache/shell/chpwd-recent-dirs"
zstyle ':chpwd:*' recent-dirs-pushd true

setopt auto_cd


# aliases and functions
alias l='ls -hlF'
alias ll='ls -ahlF'
alias g="git"
alias v="vim"
alias m="m"
alias nv="nvim"
alias nr="npm run"
alias pm="python manage.py"
alias be="bundle exec"
alias j2c="js2coffee"
alias xo="xdg-open"

alias cb="xsel --clipboard --input"
alias cbp="xsel --clipboard --output"
alias psp='ps aux | peco'

alias rr='exec zsh -l'
alias xm='setxkbmap && xmodmap ~/.Xmodmap'

alias path="echo \$PATH | sed 's/:/\\n/g'"

alias tap_production="export NODE_ENV=production"
alias untap_production="unset NODE_ENV"

alias A='awk'
alias G='grep'
alias H='head'
alias L='less'
alias P='peco'
alias S='sed'
alias T='tail'
alias W='wc'

if which trash-put &> /dev/null; then
  alias rm='trash-put'
fi

function cl() {
  local dir=$(find . -maxdepth 1 -type d ! -path "*/.*"| peco)
  if [ ! -z "$dir" ] ; then
    cd "$dir"
  fi
}

function cdr-peco() {
  local dir=$(cdr -l | awk '{ print $2 }' | peco)
  if [ -n $dir ]; then
    BUFFER="cd $dir"
    zle accept-line
  fi
  zle clear-screen
}
zle -N cdr-peco


function gh() {
  local dir=$(ghq list -p | peco)
  if [ ! -z "$dir" ] ; then
    cd $dir
  fi
}

function vl() {
  local dir=$(find . -maxdepth 1 -type f ! -path "*/.*"| peco)
  if [ -r "$dir" ] ; then
    vim "$dir"
  fi
}

function lp() {
  ls -AlF $@ | peco
}

function catc() {
  cat $1 | xsel --clipboard --input
}

function copy-buffer(){
  print -rn $BUFFER | xsel --clipboard --input
}
zle -N copy-buffer


# key bindings
bindkey -e
bindkey '^L' delete-char
bindkey '^S' copy-buffer
bindkey '^G' cdr-peco
bindkey '^@' clear-screen
bindkey '^[[Z' reverse-menu-complete

bindkey '^[[1~' beginning-of-line
bindkey '^[[4~' end-of-line
bindkey '^[[3~' delete-char


# envs
export VTE_CJK_WIDTH=1
export EDITOR=vim
export FCEDIT="$EDITOR"
export VISUAL="$EDITOR"
export SUDO_EDITOR="$EDITOR"
export TERM=xterm-256color
export XDG_CONFIG_HOME=~/.config
export WINEARCH=win32
export WINEPREFIX=~/wineprefixes/current

export PATH=~/bin:$PATH
export PATH=~/dotfiles/bin:$PATH

if [ -d ~/.nodebrew ]; then
  export PATH=~/.nodebrew/current/bin:$PATH
  nodebrew use 6 > /dev/null
fi

if [ -d ~/.rbenv ]; then
  export PATH=~/.rbenv/bin:$PATH
  eval "$(rbenv init -)"
fi

if [ -d ~/.pyenv ]; then
  export PYENV_VIRTUALENV_DISABLE_PROMPT=1
  export PYENV_ROOT=$HOME/.pyenv
  export PATH=$PYENV_ROOT/bin:$PATH
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi

if [ -d ~/.phpbrew ]; then
  source ~/.phpbrew/bashrc
fi

if [ -d ~/go ]; then
  export GOPATH=~/go
  export PATH=$PATH:$GOPATH/bin
  export GO15VENDOREXPERIMENT=1
fi

