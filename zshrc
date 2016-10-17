# prompt
PROMPT="%F{cyan}%~%f "
if [ ${EUID:-${UID}} = 0 ]; then
  PROMPT=$PROMPT"%(?.%F{yellow}.%F{red})%f "
else
  PROMPT=$PROMPT"%(?.%F{yellow}.%F{red})$%f "
fi


# zplug
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


# zsh specifics
autoload -Uz colors
colors
eval `dircolors -b`

autoload -Uz compinit
compinit
zstyle ':completion:*' list-colors $LS_COLORS
# zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' ignore-parents parent pwd ..
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'

stty stop undef
stty start undef

DIRSTACKSIZE=100
setopt AUTO_PUSHD

autoload -Uz compinit && compinit

zstyle ':completion:*' menu select
zstyle ':completion:*:cd:*' ignore-parents parent pwd
zstyle ':completion:*:descriptions' format '%BCompleting%b %U%d%u'

autoload -Uz add-zsh-hock
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook

mkdir -p $HOME/.cache/shell/

zstyle ':completion:*' recent-dirs-insert both
zstyle ':chpwd:*' recent-dirs-max 500
zstyle ':chpwd:*' recent-dirs-default true
zstyle ':chpwd:*' recent-dirs-file "$HOME/.cache/shell/chpwd-recent-dirs"
zstyle ':chpwd:*' recent-dirs-pushd true

setopt auto_cd


# aliases and functions
alias g="git"
alias v="vim"
alias nv="nvim"
alias l='ls -hlF'
alias ll='ls -ahlF'

alias cb="xsel --clipboard --input"
alias cbp="xsel --clipboard --output"
alias psp='ps aux | peco'

alias rr='exec zsh -l'
alias xm='setxkbmap && xmodmap ~/.Xmodmap'

alias nr="npm run"
alias pm="python manage.py"
alias be="bundle exec"
alias j2c="js2coffee"
alias xo="xdg-open"

alias echo-path="echo \$PATH | sed 's/:/\\n/g'"
alias docker-clean="docker ps -a -q -f 'status=exited' | xargs --no-run-if-empty docker rm -v"
alias docker-cleani="docker images -q -f 'dangling=true' | xargs --no-run-if-empty docker rmi"

alias tap_production="export NODE_ENV=production"
alias untap_production="unset NODE_ENV"

alias -g A='| awk'
alias -g G='| grep'
alias -g H='| head'
alias -g L='| less'
alias -g P='| peco'
alias -g S='| sed'
alias -g T='| tail'
alias -g W='| wc'

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
bindkey '^J' delete-char
bindkey '^S' copy-buffer
bindkey '^G' cdr-peco
bindkey '^[[Z' reverse-menu-complete

# envs
export VTE_CJK_WIDTH=1
export EDITOR=vim
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

