# 🐡　🐠　🐟

###* Oh My Fish

set -q XDG_DATA_HOME
  and set -x OMF_PATH "$XDG_DATA_HOME/omf"
  or set -x OMF_PATH "$HOME/.local/share/omf"
source $OMF_PATH/init.fish

###* user environments
#
set PATH $HOME/bin $PATH
set -x XDG_CONFIG_HOME $HOME/.config

function fish_greeting
end

###* aliases

alias g="git"
alias v="vim"
alias ll='ls -ahlF'

alias nr="npm run"
alias pm="python manage.py"
alias be="bundle exec"
alias j2c="js2coffee"

alias cb="xsel --clipboard --input"
alias cbp="xsel --clipboard --output"
alias xopen="xdg-open"
alias docker-clean="docker ps -a -q -f \"status=exited\" | xargs --no-run-if-empty docker rm -v"
alias docker-cleani="docker images -q -f \"dangling=true\" | xargs --no-run-if-empty docker rmi"

alias tap_production="export NODE_ENV=production"
alias untap_production="unset NODE_ENV"

alias reload-fish='exec fish -l'


###* xxxenv

if [ -d "$HOME/.nodebrew" ];
  set -x PATH $HOME/.nodebrew/current/bin $PATH
  nodebrew use 4 > /dev/null
end

if [ -d "$HOME/.rbenv" ];
  set -x PATH $HOME/.rbenv/bin $PATH
  set -x PATH $HOME/.rbenv/shims $PATH
  rbenv rehash >/dev/null ^&1
end

if [ -d "$HOME/.pyenv" ];
  set -x PYENV_VIRTUALENV_DISABLE_PROMPT 1
  set -x PYENV_ROOT "$HOME/.pyenv"
  set -x PATH "$PYENV_ROOT/bin" $PATH
  . (pyenv init - | psub)
  . (pyenv virtualenv-init - | psub)
end

if [ -d "$HOME/.phpbrew" ];
  source ~/.phpbrew/bashrc
end

if [ -d "$HOME/go" ]
  set -x GOPATH ~/go
  set -x PATH $GOPATH/bin $PATH
  set -x GO15VENDOREXPERIMENT 1
end


###* git status
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate 'yes'
set __fish_git_prompt_showuntrackedfiles 'yes'
set __fish_git_prompt_showupstream 'yes'
set __fish_git_prompt_color_branch yellow
set __fish_git_prompt_color_upstream_ahead green
set __fish_git_prompt_color_upstream_behind red

# set __fish_git_prompt_char_dirtystate '⚡'
# set __fish_git_prompt_char_stagedstate '→'
# set __fish_git_prompt_char_untrackedfiles '☡'
# set __fish_git_prompt_char_stashstate '↩'
# set __fish_git_prompt_char_upstream_ahead '+'
# set __fish_git_prompt_char_upstream_behind '-'


###* prompt

set -g default_user ken
set -g pad ""

function prompt_pwd --description 'Print the current working directory, NOT shortened to fit the prompt'
  if test "$PWD" != "$HOME"
    printf "%s" (echo $PWD|sed -e 's|/private||' -e "s|^$HOME|~|")
  else
    echo '~'
  end
end

function prompt_segment -d "Function to show a segment"
  set -l bg $argv[1]
  set -l fg $argv[2]

  set_color -b $bg
  set_color $fg

  if [ -n "$argv[3]" ]
    echo -n -s $argv[3]
  end
end

function show_status -d "Function to show the current status"
  # if [ $RETVAL -ne 0 ]
  #   prompt_segment red white " ▲ "
  #   set pad ""
  # end
  if [ -n "$SSH_CLIENT" ]
    prompt_segment blue white " SSH: "
    set pad ""
  end
end

function show_virtualenv -d "Show active python virtual environments"
  if set -q VIRTUAL_ENV
    set -l venvname (basename "$VIRTUAL_ENV")
    prompt_segment normal white " ($venvname)"
  end
end

function show_user -d "Show user"
  if [ "$USER" != "$default_user" -o -n "$SSH_CLIENT" ]
    set -l host (hostname -s)
    set -l who (whoami)
    prompt_segment normal yellow " $who"

    if [ "$USER" != "$HOST" ]
      prompt_segment normal white "@"
      prompt_segment normal green "$host "
      set pad ""
    end
    end
end

function show_pwd -d "Show the current directory"
  set -l pwd (prompt_pwd)
  prompt_segment normal cyan "$pad$pwd "
end

function show_prompt -d "Shows prompt with cue for current priv"
  set -l uid (id -u $USER)
  if [ $uid -eq 0 ]
    prompt_segment normal yellow " # "
    set_color normal
    echo -n -s " "
  else
    if [ $RETVAL -ne 0 ]
      prompt_segment normal yellow "🐡  "
    else
      prompt_segment normal yellow "🐟  "
    end
  end

  set_color normal
end

function fish_prompt
  set -g RETVAL $status
  show_status
  show_virtualenv
  show_user
  show_pwd
  show_prompt
end


function get_git_status -d "Gets the current git status"
  if command git rev-parse --is-inside-work-tree >/dev/null 2>&1
    set -l dirty (command git status -s --ignore-submodules=dirty | wc -l | sed -e 's/^ *//' -e 's/ *$//' 2> /dev/null)
    set -l ref (command git describe --tags --exact-match ^/dev/null ; or command git symbolic-ref --short HEAD 2> /dev/null ; or command git rev-parse --short HEAD 2> /dev/null)

    if [ "$dirty" != "0" ]
      set_color -b normal
      set_color blue
      echo "➕ $dirty"
      if [ "$dirty" != "1" ]
        echo "s"
      end
      set_color normal
      echo " |"
      set_color purple
    else
      set_color normal
      echo " |"
      set_color green
    end

    echo " $ref "
    set_color normal
   end
end

function fish_right_prompt -d "Prints right prompt"
  # get_git_status
  set_color normal
  printf '%s ' (__fish_git_prompt)
  set_color normal
end

