# Define reload alias at least
alias r='exec zsh -l'
function reload-zsh() {
  BUFFER="exec zsh -l"
  zle accept-line
  zle reset-prompt
}
zle -N reload-zsh
bindkey -e
bindkey '^r' reload-zsh

# Performance profiling
# zmodload zsh/zprof && zprof

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
  zplug 'endaaman/zsh-git-prompt', use:'zshrc.sh'
  zplug 'endaaman/lxd-completion-zsh'
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
dirname="%F{006}%~%f"

if $is_root; then
  prompt_symbol='#'
else
  prompt_symbol='$'
fi
prompt_colored_symbol="%(?.%F{011}.%F{001})$prompt_symbol%f"

PROMPT="$pre_prompt$dirname $prompt_colored_symbol "


###* Alias

alias A='awk'
alias G='grep'
alias H='head'
alias L='less'
alias S='sed'
alias T='tail'
alias W='wc'
alias F='fzf'
if which exa &> /dev/null; then
  alias l='exa -agbl'
  alias ll='exa -agbl'
else
  alias l='ls -ahlF --color=auto'
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
alias xo='xdg-open $@ &> /dev/null'
alias s='systemctl'
alias en='export LANG=en_US.utf8'
alias ja='export LANG=ja_JP.utf-8'
alias nr='npm run'
alias pm='python manage.py'
alias be='bundle exec'
alias cb='xsel --clipboard --input'
alias cbp='xsel --clipboard --output'
alias psp='ps aux | fzf'
alias lp='ls -AlF $@ | fzf'
alias catc='cat $@ | xsel --clipboard --input'
alias xm='setxkbmap -option && xmodmap ~/.Xmodmap'
# alias xmj='setxkbmap -rules evdev -model jp106 -layout jp && xmodmap ~/dotfiles/Xmodmap_jis'
alias path="echo \$PATH | sed 's/:/\\n/g'"
alias tap_production='export NODE_ENV=production; export RAILS_ENV=production'
alias untap_production='unset NODE_ENV; unset RAILS_ENV'
alias mkdir_today='mkdir $(date "+%Y%m%d")'
alias mozc-config='env LANG=ja_JP.UTF-8 /usr/lib/mozc/mozc_tool --mode=config_dialog'

if which trash-put &> /dev/null; then
  alias rm='trash-put'
fi
if which colordiff &> /dev/null; then
  alias diff='colordiff'
fi
alias https='http --default-scheme=https'

###* Functions

function today() {
  local t=$(date "+%Y%m%d")
  mkdir -p $t
  cd $t
}

function gh() {
  local dir=$(ghq list -p | fzf)
  if [ ! -z "$dir" ] ; then
    cd $dir
  fi
}

###* Widget

function goto-today() {
  local t=$(date "+%Y%m%d")
  local dir="$HOME/tmp/$t"
  mkdir -p $dir
  cd $dir
  zle accept-line
}
zle -N goto-today

function copy-buffer() {
  print -rn $BUFFER | xsel --clipboard --input
}
zle -N copy-buffer

function magic-return() {
  if [[ -n $BUFFER ]]; then
    zle accept-line
    return
  fi
  local l=$(ls -alhF --group-directories-first | tail -n+2 | grep -v ' \./' | fzf --no-sort)
  local a=$(echo $l | awk '{$1=$2=$3=$4=$5=$6=$7=$8="" }1' | sed 's/^ *//g')
  a=$(echo "${a% ->*}" | xargs -I{} printf %q "{}")
  if [[ -z "$a" ]]; then
    zle reset-prompt
    # zle accept-line
    return
  fi
  if [ -d $a ]; then
    LBUFFER=""
    RBUFFER="$a"
  else
    LBUFFER=""
    RBUFFER=" $a"
  fi
  zle reset-prompt
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

function cd-ghq {
  local a=$(ghq list -p | fzf --no-sort +m --query "$BUFFER")
  if [[ -n $a ]]; then
    LBUFFER="cd $a"
    RBUFFER=""
    zle accept-line
  fi
  zle reset-prompt
}
zle -N cd-ghq

function cd-upper() {
  BUFFER="cd .."
  zle accept-line
  # zle reset-prompt
}
zle -N cd-upper

function cd-forward() {
  BUFFER="for"
  zle reset-prompt
}
zle -N cd-forward

function cd-backward() {
  BUFFER="back"
  zle reset-prompt
}
zle -N cd-backward

function exec-commands {
  local a=$(whence -pmv '*' | fzf --no-sort +m --query "$BUFFER" | awk '{print $1}')
  if [[ -n $a ]]; then
    LBUFFER=$a
    RBUFFER=""
    zle accept-line
  fi
  zle reset-prompt
}
zle -N exec-commands

function exec-history {
  local a=$(history -r 1 | fzf --no-sort +m --query "$BUFFER" | sed 's/ *[\*0-9]* *//')
  if [[ -n $a ]]; then
    LBUFFER=$a
    RBUFFER=""
    zle accept-line
  fi
  zle reset-prompt
}
zle -N exec-history

function feed-history {
  a=$(history -r 1 | fzf --no-sort +m --query "$BUFFER" | sed 's/ *[\*0-9]* *//')
  if [[ -n $a ]]; then
    LBUFFER=$a
    RBUFFER=""
  fi
  zle reset-prompt
}
zle -N feed-history


# key bindings
bindkey "^m" magic-return
bindkey '^s' copy-buffer
bindkey '^z' run-fglast
# bindkey '^j' exec-history
# bindkey '^r' exec-commands
bindkey '^j' feed-history
bindkey '^t' goto-today
bindkey '^g' cd-ghq
# bindkey '^,' cd-upper
# bindkey '^,' cd-forward
# bindkey '^.' cd-backward
bindkey '^[[Z' reverse-menu-complete
bindkey '^[[1~' beginning-of-line
bindkey '^[[4~' end-of-line
bindkey '^[[3~' delete-char


###* Environment

export HISTFILE=${HOME}/.zsh_history
export HISTSIZE=1000
export SAVEHIST=100000

export VTE_CJK_WIDTH=0
if which nvim &> /dev/null; then
  export EDITOR=nvim
else
  export EDITOR=vim
fi
export FCEDIT="$EDITOR"
export VISUAL="$EDITOR"
export SUDO_EDITOR="$EDITOR"
# export TERM=xterm-256color
export XDG_CONFIG_HOME=~/.config
export NO_AT_BRIDGE=1
export WINEARCH=win32
export WINEPREFIX=~/.wine
export FZF_DEFAULT_OPTS='--height 50% --reverse --border --bind "tab:down,btab:up" --exact'

export PATH=~/bin:$PATH
export PATH=~/dotfiles/bin:$PATH

if which direnv &> /dev/null; then
  eval "$(direnv hook zsh)"
fi

if which luarocks &> /dev/null; then
  eval $(luarocks path --bin)
fi

###* *env

if [ -d ~/.cargo ]; then
  export PATH=~/.cargo/bin:$PATH
  export RUST_BACKTRACE=1
fi

if [ -d ~/.nodebrew ]; then
  export PATH=~/.nodebrew/current/bin:$PATH
  nodebrew use 10 1>/dev/null
  fpath+=~/.nodebrew/completions/zsh
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

if [ -d ~/.go ]; then
  export GOPATH=~/.go
  export PATH=$PATH:$GOPATH/bin
  export GO15VENDOREXPERIMENT=1
fi

export OCAMLPARAM="_,bin-annot=1"
export OPAMKEEPBUILDDIR=1


###* Option

fpath+=~/.zsh/completions

# setopt complete_aliases
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
setopt hist_expand
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_no_store
setopt hist_reduce_blanks
setopt hist_save_no_dups
setopt hist_verify
setopt inc_append_history
setopt list_packed
setopt list_types
setopt magic_equal_subst
setopt mark_dirs
setopt no_flow_control
setopt nolistbeep
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
autoload -Uz chpwd_recent_dirs
autoload -Uz colors; colors
autoload -Uz compinit; compinit -u
autoload -Uz promptinit; promptinit

eval `dircolors -b`

if [ -f ~/.zshrc.local ]; then
  source ~/.zshrc.local
fi

compdef _docker nvidia-docker


# Performance profiling
# if (which zprof > /dev/null) ;then
#   zprof | less
# fi
