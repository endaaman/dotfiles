# Define reload alias at least
alias reload-zsh='exec zsh -l'
alias r=reload-zsh
function _reload-zsh() {
  BUFFER='reload-zsh'
  zle accept-line
  zle reset-prompt
}
zle -N _reload-zsh
bindkey -e
bindkey '^r' _reload-zsh

# Performance profiling
# zmodload zsh/zprof && zprof

if [ ~/.zshrc -nt ~/.zshrc.zwc ]; then
  zcompile ~/.zshrc
fi

local is_root=false
if [ ${EUID:-${UID}} = 0 ]; then
  is_root=true
fi

###* zplug

if [ -d ~/.zplug -a $is_root = false ]; then
  source ~/.zplug/init.zsh
  zplug 'zsh-users/zsh-completions'
  zplug 'zsh-users/zsh-syntax-highlighting', defer:2
  zplug 'endaaman/zsh-git-prompt', use:'zshrc.sh'
  zplug 'motemen/ghq', as:command, from:gh-r, rename-to:ghq
  zplug 'stedolan/jq', as:command, from:gh-r, rename-to:jq
  zplug 'junegunn/fzf-bin', as:command, from:gh-r, rename-to:fzf
  zplug 'junegunn/fzf', as:command, use:bin/fzf-tmux
  zplug 'endaaman/lxd-completion-zsh'
  zplug 'endaaman/conda-zsh-completion'

  if ! zplug check --verbose; then
    printf 'Install? [y/N]: '
    if read -q; then
      echo; zplug install
    fi
  fi
  zplug load
fi

###* Prompt

function my_prompt() {
  local pre=''
  if [ -n "$container" ] || [ -n "$SSH_CLIENT" ]; then
    if [ -n "$container" ]; then
      con="$(echo "$container" | sed 's/./\U&/g')"
    else
      con=SSH
    fi
    pre="%F{green}${con}%f:%F{magenta}$(hostname)%f"
  fi

  if $is_root; then
    dirname="%F{006}%d%f"
  else
    dirname="%F{006}%~%f"
  fi

  if $is_root; then
    symbol_glyph='#'
  else
    symbol_glyph='$'
  fi
  symbol="%(?.%F{011}.%F{001})$symbol_glyph%f"

  local python_mod=''
  if [ -n "$CONDA_DEFAULT_ENV" ]; then
    python_mod="<%F{red}$CONDA_DEFAULT_ENV%f> "
  fi

  echo "$pre$dirname $python_mod$symbol "
}
PROMPT="$(my_prompt)"

export VIRTUAL_ENV_DISABLE_PROMPT=1
function my_rprompt() {
  local rprompt=''
  if which git_super_status &> /dev/null; then
    rprompt='$(git_super_status)'
  fi
  echo $rprompt
}
RPROMPT="$(my_rprompt)"



###* Alias

alias sudo='sudo -E '
alias A='awk'
alias G='grep'
alias H='head'
alias L='less'
alias S='sed'
alias T='tail'
alias W='wc'
alias F='fzf'
alias C='xsel --clipboard --input'
if which exa &> /dev/null; then
  alias ll='exa -agbl --group-directories-first'
else
  alias ll='ls -ahlF --color=auto --group-directories-first'
fi
alias l=ll
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
alias psp='ps aux | fzf'
alias xm='setxkbmap -option && xmodmap ~/.Xmodmap'
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

###* Function

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

function cop() {
  if [[ -z $1 ]]; then
    return
  fi
  cat $1 | xsel --clipboard --input
}

function remove-empty-dirs() {
  local dirs=$(find . -maxdepth 1 -mindepth 1 -empty -type d)
  if [[ -z $dirs ]]; then
    echo 'No empty dir'
    return
  fi
  echo $dirs | xargs -L 1 rmdir
  echo removed $(echo $dirs | xargs echo)
}

###* Widget

function goto-today() {
  local dir="$HOME/tmp/$(date "+%Y%m%d")"
  mkdir -p $dir
  cd $dir
  zle accept-line
}
zle -N goto-today

function copy-buffer() {
  print -rn $BUFFER | xsel --clipboard --input
}
zle -N copy-buffer

function list-items-current-dir() {
  if [[ -n $BUFFER ]]; then
    zle accept-line
    return
  fi
  local l=$(ls -alhF --group-directories-first | tail -n+2 | grep -v ' \./' | fzf)
  local a=$(echo $l | awk '{$1=$2=$3=$4=$5=$6=$7=$8="" }1' | sed 's/^ *//g' | sed 's/\*$//')
  a=$(echo "${a% ->*}" | xargs -I{} printf %q "{}")
  if [[ -z "$a" ]]; then
    zle reset-prompt
    return
  fi
  if [[ "$a" = '../' ]]; then
    BUFFER="cd ../"
    zle accept-line
    zle reset-prompt
    return
  fi
  if [ -d $a ]; then
    LBUFFER="$a"
    RBUFFER=""
  else
    LBUFFER=""
    RBUFFER=" $a"
  fi
  zle reset-prompt
}
zle -N list-items-current-dir

function open-in-file-explorer() {
  local target='.'
  if [[ -n $BUFFER ]]; then
    target=$BUFFER
  fi
  xdg-open $target > /dev/null 2>&1
}
zle -N open-in-file-explorer

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
  local a=$(ghq list -p | fzf --query "$BUFFER")
  if [[ -n $a ]]; then
    LBUFFER="cd $a"
    RBUFFER=""
    zle accept-line
  fi
  zle reset-prompt
}
zle -N cd-ghq


function cd-dotfiles() {
  BUFFER="cd ~/dotfiles"
  zle accept-line
}
zle -N cd-dotfiles

function cd-upper() {
  BUFFER="cd .."
  zle accept-line
}
zle -N cd-upper

function cd-list() {
  d=$(dirs -p -v | fzf | awk '{ print $2 }')
  if [[ -n $d ]]; then
    BUFFER="cd $d"
    zle accept-line
  fi
  zle reset-prompt
}
zle -N cd-list

function exec-commands {
  local a=$(whence -pmv '*' | fzf --query "$BUFFER" | awk '{print $1}')
  if [[ -n $a ]]; then
    LBUFFER=$a
    RBUFFER=""
    zle accept-line
  fi
  zle reset-prompt
}
zle -N exec-commands

function exec-history {
  local a=$(history -r 1 | fzf --query "$BUFFER" | sed 's/ *[\*0-9]* *//')
  if [[ -n $a ]]; then
    LBUFFER=$a
    RBUFFER=""
    zle accept-line
  fi
  zle reset-prompt
}
zle -N exec-history

function feed-history {
  a=$(history -r 1 | fzf --query "$BUFFER" | sed 's/ *[\*0-9]* *//')
  if [[ -n $a ]]; then
    LBUFFER=$a
    RBUFFER=""
  fi
  zle reset-prompt
}
zle -N feed-history

function paste-clipboard {
  LBUFFER+="$(xsel --clipboard --output)"
}
zle -N paste-clipboard

###* Key binding

bindkey "^o" list-items-current-dir
bindkey "^x" open-in-file-explorer
bindkey '^s' copy-buffer
bindkey '^z' run-fglast
bindkey '^j' feed-history
bindkey '^t' goto-today
bindkey '^g' cd-ghq
bindkey '^[[Z' reverse-menu-complete
bindkey '^[[1~' beginning-of-line
bindkey '^[[4~' end-of-line
bindkey '^[[3~' delete-char
# with prefix
prefix='^v'
org_widget=$(bindkey $prefix | awk '{ print $2 }')
bindkey -r $prefix
bindkey $prefix$prefix $org_widget
bindkey $prefix'^j' cd-dotfiles
bindkey $prefix'^l' cd-list
bindkey $prefix'^p' paste-clipboard
# bindkey $prefix'^u' cd-upper
# bindkey $prefix'^n' cd-forward


###* Environment

export HISTFILE=$HOME/.zsh_history
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
# export XDG_CONFIG_HOME=~/.config
export NO_AT_BRIDGE=1
export WINEARCH=win32
# export WINEPREFIX=~/.wine
export FZF_DEFAULT_OPTS='--height 50% --reverse --border --bind "tab:down,btab:up" --exact --cycle  --no-sort'

export PATH=~/bin:$PATH
export PATH=~/dotfiles/bin:$PATH
export T=$(date "+%Y%m%d")
export TD=~/tmp/$T
export OCAMLPARAM="_,bin-annot=1"
export OPAMKEEPBUILDDIR=1


###* XXXenv
if which direnv &> /dev/null; then
  eval "$(direnv hook zsh)"
fi

if [ $is_root = false ] && which luarocks &> /dev/null; then
  eval $(luarocks path --bin)
fi

if [ -d ~/.cargo ]; then
  export PATH=~/.cargo/bin:$PATH
  export RUST_BACKTRACE=1
  export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"
fi

if [ -d ~/.nodebrew ]; then
  export PATH=~/.nodebrew/current/bin:$PATH
  nodebrew use 10 1>/dev/null
  fpath+=~/.nodebrew/completions/zsh
fi

if [ -d ~/.config/composer/vendor/bin ]; then
  export PATH=$PATH:$HOME/.config/composer/vendor/bin
fi

if [ -d ~/.go ]; then
  export GOPATH=~/.go
  export PATH=$PATH:$GOPATH/bin
  export GO15VENDOREXPERIMENT=1
fi

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
