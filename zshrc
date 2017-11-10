if [ ~/.zshrc -nt ~/.zshrc.zwc ]; then
  zcompile ~/.zshrc
fi

is_root=false
if [ ${EUID:-${UID}} = 0 ]; then
  is_root=true
fi


###* zplug

if [ -d ~/.zplug -a $is_root = false ]; then
  source ~/.zplug/init.zsh
  zplug 'zsh-users/zsh-completions'
  zplug 'zsh-users/zsh-syntax-highlighting', defer:2
  zplug 'olivierverdier/zsh-git-prompt', use:'zshrc.sh'
  zplug 'endaaman/lxd-completion-zsh'
  zplug 'peco/peco', as:command, from:gh-r, frozen:1
  zplug 'motemen/ghq', as:command, from:gh-r, rename-to:ghq
  zplug 'stedolan/jq', as:command, from:gh-r, rename-to:jq
  zplug 'junegunn/fzf-bin', as:command, from:gh-r, rename-to:fzf
  zplug 'junegunn/fzf', as:command, use:bin/fzf-tmux

  if ! zplug check --verbose; then
    printf 'Install? [y/N]: '
    if read -q; then
      echo; zplug install
    fi
  fi
  zplug load
  RPROMPT='$(git_super_status)'
fi


###* Prompt

if [ -n "$container" ] || [ -n "$SSH_CLIENT" ]; then
  if [ -n "$container" ]; then
    con="$(echo "$container" | sed 's/./\U&/g')"
  else
    con=SSH
  fi
  pre_prompt_content="%F{green}${con}%f:%F{magenta}$(hostname)%f"
fi

if [ -n "$pre_prompt_content" ]; then
  pre_prompt="($pre_prompt_content)"
fi

dirname="%F{cyan}%~%f"

if $is_root; then
  prompt_symbol='#'
else
  prompt_symbol='$'
fi
prompt_colored_symbol="%(?.%F{yellow}.%F{red})$prompt_symbol%f"

PROMPT="$pre_prompt$dirname $prompt_colored_symbol "


###* Alias

if which trash-put &> /dev/null; then
  alias l='exa -lb'
  alias ll='exa -lb'
else
  alias l='ls -hlF'
  alias ll='ls -ahlF --color=auto'
fi
alias sudo='sudo -E '
alias mv='mv -v'
alias cp='cp -v'
alias rename='rename -v'
alias g='git'
alias ta='tig --all'
alias v='vim'
alias vi='vim -u NONE'
alias n='nvim'
alias xo='xdg-open'
alias s='systemctl'
alias en='export LANG=en_US.utf8'
alias ja='export LANG=ja_JP.utf-8'

alias nr='npm run'
alias pm='python manage.py'
alias be='bundle exec'

alias cb='xsel --clipboard --input'
alias cbp='xsel --clipboard --output'
alias psp='ps aux | fzf'

alias rr='exec zsh -l'
alias xm='setxkbmap -rules evdev -model us -layout us && xmodmap ~/dotfiles/Xmodmap_us'
alias xmj='setxkbmap -rules evdev -model jp106 -layout jp && xmodmap ~/dotfiles/Xmodmap_jis'

alias path="echo \$PATH | sed 's/:/\\n/g'"

alias tap_production='export NODE_ENV=production; export RAILS_ENV=production'
alias untap_production='unset NODE_ENV; unset RAILS_ENV'

alias A='awk'
alias G='grep'
alias H='head'
alias L='less'
alias S='sed'
alias T='tail'
alias W='wc'
alias P='peco'
alias F='fzf'

if which trash-put &> /dev/null; then
  alias rm='trash-put'
fi


###* Widget

function __git_files () {
    _wanted files expl 'local files' _files
}

function cl() {
  local file=$(find . -maxdepth 1 -type d ! -path "*/.*"| fzf)
  if [ ! -z "$file" ] ; then
    cd "$file"
  fi
}

function cdr() {
  local dir=$(cdr -l | awk '{ print $2 }' | fzf)
  if [ -n $dir ]; then
    BUFFER="cd $dir"
    zle accept-line
  fi
  zle clear-screen
}
zle -N cdr


function gh() {
  local dir=$(ghq list -p | fzf)
  if [ ! -z "$dir" ] ; then
    cd $dir
  fi
}

function vl() {
  local file=$(find . -maxdepth 1 -type f ! -path "*/.*"| fzf)
  if [ -r "$file" ] ; then
    nvim "$file"
  fi
}

function lp() {
  ls -AlF $@ | fzf
}

function catc() {
  cat $1 | xsel --clipboard --input
}

function copy-buffer(){
  print -rn $BUFFER | xsel --clipboard --input
}
zle -N copy-buffer

function magic-return() {
  if [[ -z $BUFFER ]]; then
    # behavior when buffer is emptry
    zle accept-line
  else
    zle accept-line
  fi
}
zle -N magic-return


function run-fglast {
  if [[ -z $(jobs) ]]; then
    return
  fi
  zle push-input
  BUFFER="fg %"
  zle accept-line
}
zle -N run-fglast

# key bindings
bindkey -e
bindkey "^m" magic-return
bindkey '^s' copy-buffer
bindkey '^g' cdr-peco
bindkey '^@' clear-screen
bindkey '^z' run-fglast
bindkey '^[[Z' reverse-menu-complete

bindkey '^[[1~' beginning-of-line
bindkey '^[[4~' end-of-line
bindkey '^[[3~' delete-char


###* Environment

export HISTFILE=${HOME}/.zsh_history
export HISTSIZE=1000
export SAVEHIST=100000

export VTE_CJK_WIDTH=1
if which nvim &> /dev/null; then
  export EDITOR=nvim
else
  export EDITOR=vim
fi
export FCEDIT="$EDITOR"
export VISUAL="$EDITOR"
export SUDO_EDITOR="$EDITOR"
export TERM=xterm-256color
export XDG_CONFIG_HOME=~/.config
export NO_AT_BRIDGE=1
export WINEARCH=win32
export WINEPREFIX=~/.wine
export FZF_DEFAULT_OPTS='--height 40% --reverse --border --bind "tab:down,btab:up"'

export PATH=~/bin:$PATH
export PATH=~/dotfiles/bin:$PATH


###* *env

if [ -d ~/.nodebrew ]; then
  export PATH=~/.nodebrew/current/bin:$PATH
  nodebrew use 8 1>/dev/null
  fpath=(~/.nodebrew/completions/zsh $fpath)
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

if [ -d ~/.config/composer/vendor/bin ]; then
  export PATH=$PATH:$HOME/.config/composer/vendor/bin
fi

if [ -d ~/go ]; then
  export GOPATH=~/go
  export PATH=$PATH:$GOPATH/bin
  export GO15VENDOREXPERIMENT=1
fi

export OCAMLPARAM="_,bin-annot=1"
export OPAMKEEPBUILDDIR=1


###* Option

# setopt ignoreeof # disable C-d
setopt always_last_prompt
setopt append_history
setopt auto_cd
setopt auto_list
setopt auto_menu
setopt auto_pushd
setopt autoremoveslash
setopt complete_in_word
setopt extended_glob
setopt extended_history
setopt glob
setopt glob_complete
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_no_store
setopt hist_reduce_blanks
setopt hist_verify
setopt list_packed
setopt list_types
setopt magic_equal_subst
setopt mark_dirs
setopt no_flow_control
setopt numeric_glob_sort
setopt print_eight_bit
setopt pushd_ignore_dups
setopt rec_exact
setopt share_history
unsetopt list_beep

mkdir -p $HOME/.cache/shell/
zstyle ':chpwd:*' recent-dirs-default true
zstyle ':chpwd:*' recent-dirs-file "$HOME/.cache/shell/chpwd-recent-dirs"
zstyle ':chpwd:*' recent-dirs-max 500
zstyle ':chpwd:*' recent-dirs-pushd true
zstyle ':completion:*' format '%B%d%b'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' ignore-parents parent pwd ..
zstyle ':completion:*' list-colors $LS_COLORS
zstyle ':completion:*' menu select
zstyle ':completion:*' recent-dirs-insert both
zstyle ':completion:*' use-cache yes
zstyle ':completion:*' verbose yes
zstyle ':completion:*:cd:*' ignore-parents parent pwd
zstyle ':completion:*:descriptions' format '%BCompleting%b %U%d%u'
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'
zstyle ':completion:*:warnings' format 'No matches for: %d'

# disable C-q C-s
stty stop undef
stty start undef

DIRSTACKSIZE=100
HISTSIZE=100000
SAVEHIST=100000


###* autoload

autoload -Uz add-zsh-hock
autoload -Uz cdr
autoload -Uz chpwd_recent_dirs
autoload -Uz colors; colors
autoload -Uz compinit; compinit -u
autoload -Uz promptinit; promptinit

eval `dircolors -b`

if [ -f ~/.zshrc.local ]; then
  source ~/.zshrc.local
fi
