export VTE_CJK_WIDTH=1
export EDITOR=vim
export TERM=xterm-256color


# colors
autoload -Uz colors
colors
eval `dircolors -b`

# completion
autoload -Uz compinit
compinit
zstyle ':completion:*' list-colors $LS_COLORS
# zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' ignore-parents parent pwd ..
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'


# prompt
PROMPT="%F{cyan}%~%f "
if [ ${EUID:-${UID}} = 0 ]; then
  PROMPT=$PROMPT"%F{yellow}#%f "
else
  PROMPT=$PROMPT"%F{yellow}$%f "
fi
RPROMPT='$(git_super_status)'


# for git
if [ -d "$HOME/.git-prompt" ]; then
  source ~/.git-prompt/zshrc.sh
fi


# node.js
if [ -d "$HOME/.nodebrew" ]; then
  export PATH=$HOME/.nodebrew/current/bin:$PATH
  nodebrew use 6 > /dev/null
fi


# ruby
if [ -d "$HOME/.rbenv" ]; then
  export PATH=$HOME/.rbenv/bin:$PATH
  eval "$(rbenv init -)"
fi


# python
if [ -d "$HOME/.pyenv" ]; then
  export PYENV_VIRTUALENV_DISABLE_PROMPT=1
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi


# PHP
if [ -d "$HOME/.phpbrew" ]; then
  source ~/.phpbrew/bashrc
fi


# GO
if [ -d "$HOME/go" ]; then
  export GOPATH=~/go
  export PATH=$PATH:$GOPATH/bin
  export GO15VENDOREXPERIMENT=1
fi


# user
export PATH="$HOME/bin:$PATH"
export XDG_CONFIG_HOME=$HOME/.config


# alias
alias g="git"
alias v="vim"
alias ll='ls -ahlF'

alias nr="npm run"
alias pm="python manage.py"
alias be="bundle exec"
alias j2c="js2coffee"

alias cb="xsel --clipboard --input"
alias cbp="xsel --clipboard --output"
alias xopen="xdg-open"
alias docker-clean="docker ps -a -q -f \"status=exited\" | xargs --no-run-if-empty docker rm -v"
alias docker-cleani="docker images -q -f \"dangling=true\" | xargs --no-run-if-empty docker rmi"

alias tap_production="export NODE_ENV=production"
alias untap_production="unset NODE_ENV"

alias reload-zshrc='exec zsh -l'
