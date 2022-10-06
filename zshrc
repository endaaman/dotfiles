# Define reload alias at least
alias reload-zsh='exec zsh -l'
if [ -f ~/.zshrc.pre ]; then
  source ~/.zshrc.pre
fi
alias r=reload-zsh
function _reload-zsh() {
  BUFFER='reload-zsh'
  zle accept-line
  zle reset-prompt
}
zle -N _reload-zsh
bindkey -e
bindkey '^r' _reload-zsh

if [ -n "$PROFILING" ]; then
  zmodload zsh/zprof
  zprof
fi

if [ ~/.zshrc -nt ~/.zshrc.zwc ]; then
  zcompile ~/.zshrc
fi

if [ ${EUID:-${UID}} = 0 ]; then
  IS_ROOT='is_root'
fi

# DEFAUTL_PATH=$PATH
# DOTFILES_PATH=$(realpath $(dirname "$0"))

###* zplug

# if [ -d ~/.zplug -a -z "$IS_ROOT" ]; then
#   source ~/.zplug/init.zsh
#   zplug 'zsh-users/zsh-completions'
#   zplug 'zsh-users/zsh-syntax-highlighting', defer:2
#   zplug 'endaaman/zsh-git-prompt', use:'zshrc.sh'
#   # zplug 'stedolan/jq', as:command, from:gh-r, rename-to:jq
#   zplug 'junegunn/fzf-bin', as:command, from:gh-r, rename-to:fzf
#   zplug 'junegunn/fzf', as:command, use:bin/fzf-tmux
#   zplug 'endaaman/lxd-completion-zsh'
#   zplug 'esc/conda-zsh-completion'
#   if ! zplug check --verbose; then
#     printf 'Install? [y/N]: '
#     if read -q; then
#       echo; zplug install
#     fi
#   fi
#   zplug load
# fi

if [ -f ~/.local/share/zinit/zinit.git/zinit.zsh -a -z "$IS_ROOT" ]; then
  source ~/.local/share/zinit/zinit.git/zinit.zsh
  autoload -Uz _zinit
  (( ${+_comps} )) && _comps[zinit]=_zinit

  zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust \
    zsh-users/zsh-completions \
    zsh-users/zsh-syntax-highlighting \
    esc/conda-zsh-completion \
    endaaman/lxd-completion-zsh \
    src'zshrc.sh' endaaman/zsh-git-prompt \
    from"gh-r" as"program" junegunn/fzf
fi


###* Option

fpath+=~/.zsh/completions

# setopt complete_aliases
# setopt ignoreeof # disable C-d
setopt always_last_prompt
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
setopt prompt_subst
setopt pushd_ignore_dups
setopt rec_exact
setopt share_history
unsetopt list_beep


###* autoload

autoload -Uz add-zsh-hock
autoload -Uz chpwd_recent_dirs
autoload -Uz colors; colors
autoload -Uz compinit; compinit -u
autoload -Uz promptinit; promptinit
autoload -Uz zmv
eval `dircolors -b`


###* Prompt

function my_prompt() {
  local pre=''
  if [ -n "$container" ] || [ -n "$SSH_CLIENT" ]; then
    if [ -n "$container" ]; then
      con="$(echo "$container" | sed 's/./\U&/g')"
    else
      con=SSH
    fi
    pre="%F{green}$con%f:%F{magenta}$(hostname)%f"
  fi

  if [ -n "$IS_ROOT" ]; then
    symbol_glyph='#'
    dirname="%F{006}%d%f"
  else
    symbol_glyph='$'
    dirname="%F{006}%~%f"
  fi

  symbol="%(?.%F{011}.%F{001})$symbol_glyph%f"

  local python_mod=''
  if [ -n "$CONDA_DEFAULT_ENV" ]; then
    python_mod="<%F{red}$CONDA_DEFAULT_ENV%f> "
  fi

  if [ -n "$VIRTUAL_ENV" ]; then
    local name=$(basename $VIRTUAL_ENV)
    python_mod="<%F{magent}$name%f> "
  fi

  echo "$pre$dirname $python_mod$symbol "
}

if [ -n "$IS_ROOT" ]; then
  PROMPT="$(my_prompt)"
else
  PROMPT='$(my_prompt)'
fi

function my_rprompt() {
  local rprompt=''
  if which git_super_status &> /dev/null; then
    rprompt="$(git_super_status)"
  fi
  echo $rprompt
}

if [ -n "$IS_ROOT" ]; then
  RPROMPT="$(my_rprompt)"
else
  RPROMPT='$(my_rprompt)'
fi


###* Environment

export VTE_CJK_WIDTH=0
# export XDG_CONFIG_HOME=~/.config
export NO_AT_BRIDGE=1
# export WINEPREFIX=~/.wine

export C=$(date '+%Y%m')
export CD=~/tmp/$C
if [ -n "$DISPLAY" ] && which xdotool &> /dev/null; then
  export WINDOWID=$(xdotool getwindowfocus)
fi


###* XXXenv

if [ -z "$IS_ROOT" ]; then
  # only non root
  if [ which luarocks &> /dev/null; then
    eval $(luarocks path --bin)
  fi

  if which pip &> /dev/null; then
    eval "$(pip completion --zsh)"
  fi
fi

if [ -d ~/.cargo ]; then
  export PATH=~/.cargo/bin:$PATH
  export RUST_BACKTRACE=1
  export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"
fi

if [ -d ~/.nodebrew ]; then
  export PATH=~/.nodebrew/current/bin:$PATH
  nodebrew use 16 1>/dev/null
  # fpath+=~/.nodebrew/completions/zsh
fi

###* nvm is too slow
# if [ -d ~/.nvm ]; then
#   source ~/.nvm/nvm.sh
# fi

if [ -d ~/.config/composer/vendor/bin ]; then
  export PATH=$PATH:$HOME/.config/composer/vendor/bin
fi

export GOPATH=~/.go
export PATH=$PATH:$GOPATH/bin
export GO15VENDOREXPERIMENT=1
export GO11MODULE=off

if which pipenv &> /dev/null; then
  eval "$(_PIPENV_COMPLETE=zsh_source pipenv)"
fi

if [ -d ~/.poetry ]; then
  export PATH="$HOME/.poetry/bin:$PATH"
fi

if which java &> /dev/null; then
  export JAVA_HOME=$(readlink -f /usr/bin/java | sed "s:/bin/java::")
fi

__conda_setup="$("$CONDA_BASE/bin/conda" 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
  eval "$__conda_setup"
else
  if [ -f "$CONDA_BASE/etc/profile.d/conda.sh" ]; then
    . "$CONDA_BASE/etc/profile.d/conda.sh"
  fi
fi
unset __conda_setup

###* Function

function remove-empty-dirs() {
  local -A opthash
  zparseopts -D -M -A opthash -- s -silent=s
  if [[ -n "${opthash[(i)-s]}" ]]; then
    local o_silent=1
  fi

  target=$1
  if [ ! -d $target ]; then
    target='.'
  fi
  local empty_dirs=$(find $target -mindepth 1 -maxdepth 2 -empty -type d -not -path '*/\.git/*')
  if [ -z "$empty_dirs" ]; then
    if [ -z "$o_silent" ]; then
      echo 'nothing to delete'
    fi
    return
  fi
  if [ -z "$o_silent" ]; then
    echo $empty_dirs | xargs -L 1 rmdir
    echo removed $empty_dirs
  fi
}

function mkdir-current() {
  remove-empty-dirs -s ~/tmp
  mkdir -p $CD
  ln -fsn $CD ~/tmp/current
}


function chpwd() {
  powered_cd_add_log
}

function powered_cd_add_log() {
  local i=0
  cat ~/.powered_cd.log | while read line; do
    (( i++ ))
    if [ i = 30 ]; then
      sed -i -e "30,30d" ~/.powered_cd.log
    elif [ "$line" = "$PWD" ]; then
      sed -i -e "${i},${i}d" ~/.powered_cd.log
    fi
  done
  echo "$PWD" >> ~/.powered_cd.log
}

function powered_cd() {
  if [ $# = 0 ]; then
    # cd $(tac ~/.powered_cd.log | fzf)
  elif [ $# = 1 ]; then
    cd $1
  else
    echo "powered_cd: too many arguments"
  fi
}

_powered_cd_history() {
  # local _l=(aaa bbb ccc ddd)
  local -a _l=(${(@f)"$(_call_program history tac ~/.powered_cd.log)"})
  _describe -t history "Directory history" _l
}

_powered_cd() {
  _alternative 'files:Local:_files' 'arguments:custom arg:_powered_cd_history'
  # _arguments -C \
  #   '1: : _files _powered_cd_history'
}

compdef _powered_cd cd

function touch-ipynb() {
  if [[ -z "$1" ]]; then
    echo 'arg needed'
    return 1
  fi
  cp $HOME/dotfiles/template.ipynb $1.ipynb
}


###* Widget

function goto-current() {
  mkdir-current
  cd $CD
  zle accept-line
}
zle -N goto-current

function toggle-fgbg {
  if [[ -z $(jobs) ]]; then
    return
  fi
  zle push-input
  BUFFER="fg %"
  zle accept-line
}
zle -N toggle-fgbg

function copy-buffer() {
  local data=$BUFFER
  if [[ -z "$BUFFER" ]]; then
    data=$(pwd)
  fi
  print -rn $data | cb-copy
}
zle -N copy-buffer

function paste-clipboard {
  LBUFFER+="$(cb-paste)"
}
zle -N paste-clipboard

function goto-realpath {
  cd $(realpath .)
  zle accept-line
}
zle -N goto-realpath

function open-in-file-explorer() {
  local target='.'
  if [[ -n $BUFFER ]]; then
    target=$BUFFER
  fi
  xdg-open $target > /dev/null 2>&1
}
zle -N open-in-file-explorer

function edit-line() {
  touch /tmp/LINE.sh
  echo $BUFFER > /tmp/LINE.sh
  $EDITOR /tmp/LINE.sh
  LBUFFER="$(cat /tmp/LINE.sh)"
  RBUFFER=""
}
zle -N edit-line

function select-items() {
  local last=$(echo $BUFFER | tr ' ' '\n' | tail -1)
  local result=$(eval $1 | fzf --query "$last"| eval $2)
  if [[ -z "$result" ]]; then
    zle reset-prompt
    return
  fi
  local base=$(echo $BUFFER | tr ' ' '\n' | head -n-1 | tr '\n' ' ')
  LBUFFER="$base$result"
  RBUFFER=""
  zle reset-prompt
  if [[ -n "$3" ]]; then
    zle accept-line
  fi
}

function select-items-full {
  local result=$(eval $1 | fzf --query "$BUFFER"| eval $2)
  if [[ -z "$result" ]]; then
    zle reset-prompt
    return
  fi
  LBUFFER="$result"
  RBUFFER=""
  zle reset-prompt
  if [[ -n "$3" ]]; then
    zle accept-line
  fi
}
zle -N select-items-full

function select-repos {
  select-items-full \
    'ghr list | sort' \
    'cat'
}
zle -N select-repos

function select-history {
  select-items-full \
    'history -r 1' \
    'sed "s/ *[\*0-9]* *//"'
}
zle -N select-history

function select-cwd-files() {
  select-items \
    'ls -alhF --group-directories-first | tail -n+2 | grep -v " \./"' \
    'awk '\''{print $9}'\'' | sed -e "s/^ *//g" -e "s/\*$//"'
}
zle -N select-cwd-files

function select-excutables() {
  select-items \
    'whence -pm "*"' \
    'cat'
}
zle -N select-excutables

function select-cwd-files-2() {
  select-items \
    'find -maxdepth 2' \
    'cat'
}
zle -N select-cwd-files-2

function select-branches() {
  select-items \
    'git branch -a | sort' \
    'sed -e "s/^\*//" | sed -e "s/^ \+//"'
}
zle -N select-branches

function select-dein-plugin-dirs() {
  select-items \
    'find ~/.cache/dein/repos/github.com -maxdepth 2 -mindepth 2 -type d' \
    'cat'
}
zle -N select-dein-plugin-dirs

function select-go-projects() {
  select-items \
    'find $GOPATH/src -maxdepth 3 -mindepth 2 -type d -not -name '.git'' \
    'cat'
}
zle -N select-go-projects

function select-git-files() {
  select-items \
    'git ls-files | sort' \
    'cat'
}
zle -N select-git-files

function select-directry-history() {
  select-items \
    'tac ~/.powered_cd.log' \
    'cat' \
    1
}
zle -N select-directry-history

function select-pacman-files() {
  select-items \
    'pacman -Ql' \
    'cat'
}
zle -N select-pacman-files

function select-pacman-libs() {
  select-items 'pacman -Qq' 'cat'
}
zle -N select-pacman-libs

function select-conda-envs() {
  select-items \
    'conda env list -q | head -n -1 | tail -n +3' \
    'awk '\''{print $1}'\'' | cat <(echo -n "conda activate ") -' \
    1
}
zle -N select-conda-envs

###* Key binding

bindkey "^o" select-cwd-files
bindkey '^j' select-history
bindkey "^x" open-in-file-explorer
bindkey '^s' copy-buffer
bindkey '^g' select-repos
bindkey '^t' goto-current
bindkey '^z' toggle-fgbg
bindkey '^[[Z' reverse-menu-complete
bindkey '^[[1~' beginning-of-line
bindkey '^[[4~' end-of-line
bindkey '^[[3~' delete-char
# with prefix
prefix='^v'
org_widget=$(bindkey $prefix | awk '{ print $2 }')
bindkey -r $prefix
bindkey $prefix$prefix $org_widget
bindkey $prefix'^d' nop
bindkey $prefix'^i' edit-line
bindkey $prefix'^r' goto-realpath
bindkey $prefix'^b' select-branches
bindkey $prefix'^s' select-go-projects
bindkey $prefix'^g' select-dein-plugin-dirs
bindkey $prefix'^j' select-excutables
bindkey $prefix'^l' select-git-files
bindkey $prefix'^o' select-cwd-files-2
bindkey $prefix'^a' select-pacman-files
bindkey $prefix'^p' select-pacman-libs
# bindkey $prefix'^k' select-conda-envs
bindkey $prefix'^k' select-directry-history
bindkey $prefix'^y' paste-clipboard


###* Alias

alias ssudo='\sudo'
alias sudo='sudo -E '
alias G='grep'
alias F='fzf'
alias lf='ll | fzf'
alias mv='mv -v'
alias cp='cp -v'
alias rename='rename -v'
alias g='git'
alias v='vim'
alias vi='PURE_VIM=1 vim'
alias n='nvim'
alias ni='PURE_VIM=1 nvim'
alias xo='xdg-open $@ &> /dev/null'
alias s='systemctl'
alias en='LANG=en_US.utf8'
alias ja='LANG=ja_JP.utf-8'
alias nr='npm run'
alias pm='python manage.py'
alias be='bundle exec'
alias psp='ps aux | fzf'
alias path="echo \$PATH | sed 's/:/\\n/g'"
alias tap-production='export NODE_ENV=production; export RAILS_ENV=production'
alias untap-production='unset NODE_ENV; unset RAILS_ENV'
alias mozc-config='env LANG=ja_JP.UTF-8 /usr/lib/mozc/mozc_tool --mode=config_dialog'
alias inspect-pid='xprop _NET_WM_PID | cut -d " " -f 3 | xargs ps -fw'
alias use-ms-font='export FONTCONFIG_FILE=$HOME/dotfiles/misc/fonts-ms.conf'
alias gogetlegacy='GO111MODULE=off go get -u'
alias reload-udev='sudo udevadm control --reload-rules && sudo udevadm trigger'
alias mam='mamba'
alias https='http --default-scheme=https'

# replacing
if which exa &> /dev/null; then
  alias l='exa -agbl --group-directories-first --time-style long-iso'
  alias ll='exa -agbl --group-directories-first --time-style long-iso -T -L 2'
  alias lll='exa -agbl --group-directories-first --time-style long-iso -T -L 3'
else
  alias ll='ls -ahlF --color=auto --group-directories-first --time-style="+%m-%d %H:%M"'
  alias l=ll
fi
if which trash-put &> /dev/null; then
  alias rm='trash-put'
fi
if which colordiff &> /dev/null; then
  alias diff='colordiff'
fi

###* operations

({mkdir-current}&) >/dev/null

[ -e ~/.powered_cd.log ] || touch ~/.powered_cd.log

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

compdef _docker nvidia-docker

if [ -f ~/.zshrc.post ]; then
  source ~/.zshrc.post
fi

if [ -n "$PROFILING" ] && which zprof > /dev/null; then
  zprof | less
fi
