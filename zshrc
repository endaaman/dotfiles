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


###* zplug

if [ -d ~/.zplug -a -z "$IS_ROOT" ]; then
  source ~/.zplug/init.zsh
  zplug 'zsh-users/zsh-completions'
  zplug 'zsh-users/zsh-syntax-highlighting', defer:2
  zplug 'endaaman/zsh-git-prompt', use:'zshrc.sh'
  # zplug 'stedolan/jq', as:command, from:gh-r, rename-to:jq
  zplug 'junegunn/fzf-bin', as:command, from:gh-r, rename-to:fzf
  zplug 'junegunn/fzf', as:command, use:bin/fzf-tmux
  zplug 'endaaman/lxd-completion-zsh'
  zplug 'esc/conda-zsh-completion'
  if ! zplug check --verbose; then
    printf 'Install? [y/N]: '
    if read -q; then
      echo; zplug install
    fi
  fi
  zplug load
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

export HISTFILE=$HOME/.zsh_history
export HISTSIZE=100000
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
export FZF_DEFAULT_OPTS='--height 50% --reverse --border --bind "tab:down,btab:up,ctrl-j:toggle+down,ctrl-k:toggle" --exact --cycle --no-sort --multi'

export PATH=~/bin:~/.local/bin:~/dotfiles/bin:$PATH
export C=$(date '+%Y%m')
export CD=~/tmp/$C
export OCAMLPARAM="_,bin-annot=1"
export OPAMKEEPBUILDDIR=1
export VIRTUAL_ENV_DISABLE_PROMPT=1
if which xdotool &> /dev/null; then
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
  nodebrew use 14 1>/dev/null
  # fpath+=~/.nodebrew/completions/zsh
fi

###* nvm is too slow
# if [ -d ~/.nvm ]; then
#   source ~/.nvm/nvm.sh
# fi

if [ -d ~/.config/composer/vendor/bin ]; then
  export PATH=$PATH:$HOME/.config/composer/vendor/bin
fi

if [ -d ~/go ]; then
  export GOPATH=~/go
  export PATH=$PATH:$GOPATH/bin
  export GO15VENDOREXPERIMENT=1
  export GO11MODULE=off
fi

if which pipenv &> /dev/null; then
  eval "$(pipenv --completion)"
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
  target=$1
  if [ ! -d $target ]; then
    target='.'
  fi
  local empty_dirs=$(find $target -mindepth 1 -maxdepth 2 -empty -type d -not -path '*/\.git/*')
  if [ -z "$empty_dirs" ]; then
    echo 'Nothing to remove'
    return
  fi
  echo $empty_dirs | xargs -L 1 rmdir
  echo removed $empty_dirs
}

function mkdir-current() {
  remove-empty-dirs ~/tmp
  mkdir -p $CD
  ln -fsn $CD ~/tmp/current
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
  print -rn $data | xsel --clipboard --input
}
zle -N copy-buffer

function paste-clipboard {
  LBUFFER+="$(xsel --clipboard --output)"
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
  select-items-full \
    'dirs -l -v -p | tail -n+2' \
    'awk '\''{print $2}'\' \
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

###* Key binding

bindkey "^o" select-cwd-files
bindkey '^j' select-history
bindkey "^x" open-in-file-explorer
bindkey '^s' copy-buffer
bindkey '^g' select-repos
bindkey '^t' goto-current
bindkey '^z' toggle-fgbg
bindkey '^k' select-directry-history
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
bindkey $prefix'^g' select-go-projects
bindkey $prefix'^s' select-dein-plugin-dirs
bindkey $prefix'^j' select-excutables
bindkey $prefix'^l' select-git-files
bindkey $prefix'^o' select-cwd-files-2
bindkey $prefix'^a' select-pacman-files
bindkey $prefix'^p' select-pacman-libs
bindkey $prefix'^y' paste-clipboard


###* Alias

alias sudo='sudo -E '
alias G='grep'
alias F='fzf'
alias C='xsel --clipboard --input'
if which exa &> /dev/null; then
  alias l='exa -agbl --group-directories-first --time-style long-iso'
  alias ll='exa -agbl --group-directories-first --time-style long-iso -T -L 2'
  alias lll='exa -agbl --group-directories-first --time-style long-iso -T -L 3'
else
  alias ll='ls -ahlF --color=auto --group-directories-first'
  alias l=ll
fi
alias lf='ll | fzf'
alias mv='mv -v'
alias cp='cp -v'
alias rename='rename -v'
alias g='git'
alias v='vim'
alias vi='vim -u NONE'
alias n='nvim'
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

if which trash-put &> /dev/null; then
  alias rm='trash-put'
fi
if which colordiff &> /dev/null; then
  alias diff='colordiff'
fi
alias https='http --default-scheme=https'


###* operations

({mkdir-current}&) >/dev/null

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
