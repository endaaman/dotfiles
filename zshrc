# Define reload alias at least
alias reload-zsh='RELOADING=1 exec zsh -l'
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

if [ ! -f ~/.zshrc.zwc -o ~/.zshrc -nt ~/.zshrc.zwc ]; then
  zcompile ~/.zshrc
fi

if [ ${EUID:-${UID}} = 0 ]; then
  IS_ROOT='is_root'
fi

# DEFAUTL_PATH=$PATH
# DOTFILES_PATH=$(realpath $(dirname "$0"))

if [ -f ~/.local/share/zinit/zinit.git/zinit.zsh -a -z "$IS_ROOT" ]; then
  source ~/.local/share/zinit/zinit.git/zinit.zsh
  autoload -Uz _zinit
  (( ${+_comps} )) && _comps[zinit]=_zinit

  zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust \
    as"completion"  pick"_pip" srijanshetty/zsh-pip-completion \
    zsh-users/zsh-completions \
    zsh-users/zsh-syntax-highlighting \
    esc/conda-zsh-completion \
    endaaman/lxd-completion-zsh \
    as"completion"  pick"_tsp" endaaman/task-spooler-completion-zsh \
    from"gh-r" as"program" junegunn/fzf \
    romkatv/gitstatus

  gitstatus_stop 'MY' && gitstatus_start 'MY'
fi


###* Option

fpath=(~/.zsh/completion $fpath)

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
autoload -Uz edit-command-line
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
  elif command -v pyenv &> /dev/null; then
    python_version=$(pyenv version | sed 's/ .*//')
    if [ "$python_version" != "system" ]; then
      python_mod="<%F{magenta}$python_version%f> "
    fi
  fi

  echo "$pre$dirname $python_mod$symbol "
}

if [ -n "$IS_ROOT" ]; then
  PROMPT="$(my_prompt)"
else
  PROMPT='$(my_prompt)'
fi

function my_rprompt() {
  # local rprompt=''
  # if command -v git_super_status &> /dev/null; then
  #   rprompt="$(git_super_status)"
  # fi
  # echo $rprompt
  local rprompt=''
  if gitstatus_query MY && [ "$GITSTATUS" -eq 0 ]; then
    rprompt="%F{blue}[${VCS_STATUS_LOCAL_BRANCH}]%f"
    if [ "$VCS_STATUS_HAS_STAGED" -ne 0 ] || [ "$VCS_STATUS_HAS_UNSTAGED" -ne 0 ]; then
      rprompt+='%F{yellow}*%f'
    fi
    if [ "$VCS_STATUS_COMMITS_AHEAD" -ne 0 ]; then
      rprompt+='%F{green}↑%f'
    fi
    if [ "$VCS_STATUS_COMMITS_BEHIND" -ne 0 ]; then
      rprompt+='%F{red}↓%f'
    fi
  fi
  echo $rprompt
}

if [ -n "$IS_ROOT" ]; then
  RPROMPT="$(my_rprompt)"
else
  RPROMPT='$(my_rprompt)'
fi


###* Environment
###* Environment

export PATH=~/.bin:~/.local/bin:~/dotfiles/bin:/snap/bin:$PATH
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
export FB_NOAUTH=true
export PYTHON_KEYRING_BACKEND=keyring.backends.null.Keyring

export PNPM_HOME="$HOME/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"

export TF_CPP_MIN_LOG_LEVEL=3

# export VTE_CJK_WIDTH=0
# export XDG_CONFIG_HOME=~/.config
export NO_AT_BRIDGE=1

export C=$(date '+%Y%m')
export CD=~/tmp/$C
if [ -n "$TYM_ID" ] && command -v xdotool &> /dev/null; then
  export WINDOWID=$(xdotool getwindowfocus)
fi





###* CLI tools

if command -v gh &> /dev/null; then
  eval "$(gh completion -s zsh)"
fi

if [ -z "$IS_ROOT" ]; then
  # only non root
  if [ command -v luarocks &> /dev/null; then
    eval "$(luarocks path)"
  fi

  # if command -v pip &> /dev/null; then
  #   eval "$(pip completion --zsh)"
  # fi
fi

if [ -d ~/.cargo ]; then
  export PATH=~/.cargo/bin:$PATH
  export RUST_BACKTRACE=1
  export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"
fi

if [ -d ~/.nodebrew ]; then
  export PATH=~/.nodebrew/current/bin:$PATH
  nodebrew use 22 1>/dev/null
  fpath+=~/.nodebrew/completions/zsh
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

if command -v pipenv &> /dev/null; then
  eval "$(_PIPENV_COMPLETE=zsh_source pipenv)"
fi

if [ -d ~/.poetry ]; then
  export PATH="$HOME/.poetry/bin:$PATH"
fi

if [ -d ~/.pyenv ]; then
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"

  if command -v pyenv &> /dev/null; then
    eval "$(command pyenv init -)"
    if [ -d "${PYENV_ROOT}/plugins/pyenv-virtualenv" ]; then
      eval "$(command pyenv virtualenv-init -)"
    fi
  fi
fi

# pyenv() {
#   unset -f pyenv
#   if command -v pyenv &> /dev/null; then
#     eval "$(command pyenv init -)"
#     if [ -d "${PYENV_ROOT}/plugins/pyenv-virtualenv" ]; then
#       eval "$(command pyenv virtualenv-init -)"
#     fi
#   fi
#   pyenv "$@"
# }

if [ -d ~/.local/bin ] && [ -f ~/.local/bin/mise ]; then
  eval "$(~/.local/bin/mise activate zsh)"
  # do; mise plugin install usage
  # eval "$(~/.local/bin/mise completion zsh)"
  # fpath=(~/.local/share/mise/completions $fpath)
  # autoload -Uz compinit && compinit

  export MISE_VENV_HOME="$HOME/.venvs"

  vworkon() {
    local venv_name=$1
    if [ -z "$venv_name" ]; then
        echo "Usage: workon <venv_name>"
        return 1
    fi

    local venv_path="$MISE_VENV_HOME/$venv_name"
    if [ ! -d "$venv_path" ]; then
        echo "Virtual environment '$venv_name' does not exist"
        echo "Available environments:"
        ls -1 $MISE_VENV_HOME
        return 1
    fi
    source "$venv_path/bin/activate"
}

  vmkvenv() {
    local venv_name=$1
    local python_version=${2:-"3.12"}  # デフォルトバージョン
    if [ -z "$venv_name" ]; then
      echo "Usage: vmk <venv_name> [python_version]"
      return 1
    fi
    # venvディレクトリがなければ作成
    mkdir -p $MISE_VENV_HOME
    # Pythonのパスを直接取得して実行
    local python_path=$(mise which python@$python_version)
    $python_path -m venv "$MISE_VENV_HOME/$venv_name"
    # 作成したvenvをアクティベート
    vworkon $venv_name
  }
fi


if command -v java &> /dev/null; then
  export JAVA_HOME=$(readlink -f /usr/bin/java | sed "s:/bin/java::")
fi

if command -v virtualenvwrapper.sh &> /dev/null; then
  export WORKON_HOME=$HOME/.virtualenvs
  if ! command -v workon &> /dev/null && [ -z "$VIRTUAL_ENV" ]; then
    # source virtualenvwrapper.sh
    if python -c "import virtualenvwrapper" &> /dev/null; then
      source virtualenvwrapper.sh
    fi
  fi
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

# not working
# if [ -f "/opt/asdf-vm/asdf.sh" ] && [ -z "$RELOADING" ]; then
#   . /opt/asdf-vm/asdf.sh
# fi

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

function _powered_cd_history() {
  # local _l=(aaa bbb ccc ddd)
  local -a _l=(${(@f)"$(_call_program history tac ~/.powered_cd.log)"})
  _describe -t history "Directory history" _l
}

function _powered_cd() {
  _alternative 'files:Local:_files' 'arguments:custom arg:_powered_cd_history'
  # _arguments -C \
  #   '1: : _files _powered_cd_history'
}

# compdef _powered_cd cd
compdef _cd cd

function touch-ipynb() {
  if [[ -z "$1" ]]; then
    echo 'arg needed'
    return 1
  fi
  cp $HOME/dotfiles/template.ipynb $1.ipynb
}

function trash-takeback() {
  target=$(trash-list | fzf | cut -d' ' -f3)
  if [[ -z "$target" ]]; then
    echo "no item to takeback"
    return 1
  fi
  print 0 | trash-restore $target
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

function xdg-open-current-buffer() {
  local target='.'
  if [[ -n $BUFFER ]]; then
    target=$BUFFER
  fi
  xdg-open $target > /dev/null 2>&1
}
zle -N xdg-open-current-buffer

function xdg-open-current-dir() {
  xdg-open . > /dev/null 2>&1
}
zle -N xdg-open-current-dir

function edit-line() {
  touch /tmp/LINE.sh
  echo $BUFFER > /tmp/LINE.sh
  $EDITOR /tmp/LINE.sh
  LBUFFER="$(cat /tmp/LINE.sh)"
  RBUFFER=""
}
zle -N edit-line

function tspc() {
  tsp "$@" | xargs -I{} tsp -c {}
}

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

function select-excutables() {
  select-items \
    'whence -pm "*"' \
    'cat'
}
zle -N select-excutables

function select-cwd-files() {
  select-items \
    'ls-simple' \
    "awk -F '→ ' '{print \$1}'"
  # select-items \
  #   'ls-simple' \
  #   "awk -F '→ ' '{print \$NF}'"
  # select-items \
  #   'ls -alhF --group-directories-first | tail -n+2 | grep -v " \./"' \
  #   'awk '\''{print $9}'\'' | sed -e "s/^ *//g" -e "s/\*$//"'
  # select-items \
  #   'find -maxdepth 1' \
  #   'cat'
}
zle -N select-cwd-files

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

function select-tsp() {
  select-items \
    'tsp | tail -n +2' \
    "sed '/ / s/ /:/'"
}
zle -N select-tsp

zle -N edit-command-line

###* Key binding

bindkey "^o" select-cwd-files
bindkey '^j' select-history
bindkey "^x" xdg-open-current-dir
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
bindkey $prefix'^t' select-tsp
bindkey $prefix'^a' select-pacman-files
bindkey $prefix'^p' select-pacman-libs
# bindkey $prefix'^k' select-conda-envs
bindkey $prefix'^h' select-directry-history
bindkey $prefix'^y' paste-clipboard
bindkey $prefix'^x' xdg-open-current-buffer
bindkey $prefix'^k' edit-command-line


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
alias vi='VIM_NO_PLUGS=1 vim'
alias n='nvim'
alias ni='VIM_NO_PLUGS=1 nvim'
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
alias https='http --verify no'
alias p='pueue'
alias pa='pueue add'
alias pf='pueue follow'

# replacing
if command -v exa >/dev/null 2>&1; then
  alias l='exa -gbl --group-directories-first --time-style long-iso'
  alias la='exa -agbl --group-directories-first --time-style long-iso'
  alias ll='exa -agbl --group-directories-first --time-style long-iso -T -L 2'
  alias lll='exa -agbl --group-directories-first --time-style long-iso -T -L 3'
else
  alias ll='ls -ahlF --color=auto --group-directories-first --time-style="+%m-%d %H:%M"'
  alias l=ll
fi
if command -v trash-put >/dev/null 2>&1; then
  alias rm='trash-put'
  compdef _rm trash-put
fi
if command -v colordiff >/dev/null 2>&1; then
  alias diff='colordiff'
fi

# if command -v doas >/dev/null 2>&1; then
#   alias sudo='doas'
# fi

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

if [ -n "$PROFILING" ] && command -v zprof > /dev/null; then
  zprof | less
fi
