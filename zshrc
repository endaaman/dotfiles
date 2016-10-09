# prompt
PROMPT="%F{cyan}%~%f "
if [ ${EUID:-${UID}} = 0 ]; then
  PROMPT=$PROMPT"%F{yellow}#%f "
else
  PROMPT=$PROMPT"%F{yellow}$%f "
fi


# zplug
if [ -d ~/.zplug ]; then
  source ~/.zplug/init.zsh
  zplug "olivierverdier/zsh-git-prompt", use:"zshrc.sh"

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


# alias
alias g="git"
alias v="vim"
alias nv="nvim"
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
alias reload-xmodmap='setxkbmap && xmodmap ~/.Xmodmap'

function peco_cd() {
  local dir=$(find . -maxdepth 1 -type d ! -path "*/.*"| peco)
  if [ ! -z "$dir" ] ; then
    cd "$dir"
    zle accept-line
  fi
}
zle -N peco_cd
bindkey '^J' peco_cd

alias gh='cd `ghq list -p | peco`'



# envs
# export VTE_CJK_WIDTH=1
export EDITOR=vim
export TERM=xterm-256color
export XDG_CONFIG_HOME=~/.config

export PATH=~/bin:$PATH


# node.js
if [ -d ~/.nodebrew ]; then
  export PATH=~/.nodebrew/current/bin:$PATH
  nodebrew use 6 > /dev/null
fi


# ruby
if [ -d ~/.rbenv ]; then
  export PATH=~/.rbenv/bin:$PATH
  eval "$(rbenv init -)"
fi


# python
if [ -d ~/.pyenv ]; then
  export PYENV_VIRTUALENV_DISABLE_PROMPT=1
  export PYENV_ROOT=$HOME/.pyenv
  export PATH=$PYENV_ROOT/bin:$PATH
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi


# PHP
if [ -d ~/.phpbrew ]; then
  source ~/.phpbrew/bashrc
fi


# GO
if [ -d ~/go ]; then
  export GOPATH=~/go
  export PATH=$PATH:$GOPATH/bin
  export GO15VENDOREXPERIMENT=1
fi


# wine
export WINE_VERSION=1.9.19
export WINEARCH=win32
export WINEPREFIX=~/wine
pol_path=~/.PlayOnLinux/wine/linux-x86/$WINE_VERSION/bin
if [ -d $pol_path ]; then
  export PATH=$pol_path:$PATH
fi

