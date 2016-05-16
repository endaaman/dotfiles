export VTE_CJK_WIDTH=1

# direnv
eval "$(direnv hook zsh)"
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


# alias
alias g="git"
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias nr="npm run"
alias pm="python manage.py"
alias be="bundle exec"
alias j2c="js2coffee"

alias reload-dotfiles="~/dotfiles/install.sh && source .zshrc"
