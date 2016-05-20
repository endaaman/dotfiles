# init completion
autoload -U compinit
compinit
eval `dircolors -b`
zstyle ':completion:*' list-colors $LS_COLORS

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


export PATH="$HOME/bin:$PATH"

# alias
alias g="git"
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias nr="npm run"
alias pm="python manage.py"
alias be="bundle exec"
alias j2c="js2coffee"

alias docker-clean="docker rm \`docker ps -qa\`"
alias docker-cleani="docker rmi \`docker images --filter \"dangling=true\" -q\`"

alias reload-zshrc='exec zsh -l'
