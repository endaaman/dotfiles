###* Environment

export PATH=~/.bin:~/.local/bin:/snap/bin:$PATH
export HISTFILE=$HOME/.zsh_history
export HISTSIZE=100000
export SAVEHIST=100000

if which nvim &> /dev/null; then
  export EDITOR=nvim
else
  export EDITOR=vim
fi
export FCEDIT="$EDITOR"
export VISUAL="$EDITOR"
export SUDO_EDITOR="$EDITOR"
export FZF_DEFAULT_OPTS='--height 50% --reverse --border --bind "tab:down,btab:up,ctrl-j:toggle+down,ctrl-k:toggle" --exact --cycle --no-sort --multi'
export OCAMLPARAM="_,bin-annot=1"
export OPAMKEEPBUILDDIR=1
export VIRTUAL_ENV_DISABLE_PROMPT=1
