export VTE_CJK_WIDTH=1
export EDITOR=vim

# for git
source ~/.git-prompt/zshrc.sh

# prompt
PROMPT="%F{cyan}%~%f "
if [ ${EUID:-${UID}} = 0 ]; then
    PROMPT=$PROMPT"%F{yellow}#%f "
else
    PROMPT=$PROMPT"%F{yellow}$%f "
fi
RPROMPT='$(git_super_status)'


# node.js
export PATH=$HOME/.nodebrew/current/bin:$PATH
nodebrew use 4 > /dev/null

# ruby
export PATH=$HOME/.rbenv/bin:$PATH
eval "$(rbenv init -)"

# python
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# PHP
[[ -e ~/.phpbrew/bashrc ]] && source ~/.phpbrew/bashrc

export PATH="$HOME/bin:$PATH"


# completion
autoload -Uz compinit
compinit
eval `dircolors -b`
zstyle ':completion:*' list-colors $LS_COLORS
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' ignore-parents parent pwd ..
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'


# alias
alias g="git"
alias ll='ls -ahlF'
alias la='ls -A'
alias l='ls -CF'

alias nr="npm run"
alias pm="python manage.py"
alias be="bundle exec"
alias j2c="js2coffee"

alias cb="xsel --clipboard --input"
alias docker-clean="docker ps -a -q -f \"status=exited\" | xargs --no-run-if-empty docker rm -v"
alias docker-cleani="docker images -q -f \"dangling=true\" | xargs --no-run-if-empty docker rmi"

alias tap_production="export NODE_ENV=production"
alias untap_production="unset NODE_ENV"

alias reload-zshrc='exec zsh -l'
