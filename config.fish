# 🐡　🐠　🐟

###* Oh My Fish

set -q XDG_DATA_HOME
  and set -x OMF_PATH "$XDG_DATA_HOME/omf"
  or set -x OMF_PATH "$HOME/.local/share/omf"
source $OMF_PATH/init.fish

###* user environments

set -x PATH $HOME/bin $PATH
set -x XDG_CONFIG_HOME $HOME/.config
set -x VTE_CJK_WIDTH 1

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

# emoji
set __fish_git_prompt_char_dirtystate '⚡ '
set __fish_git_prompt_char_stagedstate '→ '
set __fish_git_prompt_char_untrackedfiles '☡ '
set __fish_git_prompt_char_stashstate '↩ '
set __fish_git_prompt_char_upstream_ahead '➕ '
set __fish_git_prompt_char_upstream_behind '➖ '


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

function fish_right_prompt -d "Prints right prompt"
  set_color normal
  printf '%s ' (__fish_git_prompt)
  set_color normal
end



# completion for LXD

function __fish_lxc_no_subcommand --description 'Test if lxc has yet to be given the subcommand'
  for i in (commandline -opc)
    if contains -- $i config copy delete exec file help image info launch list move profile publish remote restart restore snapshot start stop version
      return 1
    end
  end
  return 0
end

function __fish_lxc_config_subcommand --description 'Test if lxc has yet to be given the subcommand for config'
  set cmd (commandline -opc)
  if [ $cmd[2] != "config" ]
    return 1
  end
  for i in $cmd
    if contains -- $i device set get unset trust
      return 1
    end
  end
  return 0
end

function __fish_print_lxc_containers --description 'Print a list of lxc containers' -a select
  switch $select
    case running
      lxc list --fast | tail -n +4 | awk '{print $2 $4}' | egrep 'RUNNING$' | sed -e "s/RUNNING//"
    case stopped
      lxc list --fast | tail -n +4 | awk '{print $2 $4}' | egrep 'STOPPED$' | sed -e "s/STOPPED//"
    case all
      lxc list --fast | tail -n +4 | awk '{print $2}' | egrep -v '^(\||^$)'
  end
end

function __fish_print_lxc_images --description 'Print a list of lxc images'
  lxc image list | tail -n +4 | awk '{print $2}' | egrep -v '^(\||^$)'
end


complete -c lxc -f -n '__fish_lxc_no_subcommand' -a config -d "Manage configuration"
complete -c lxc -f -n '__fish_lxc_no_subcommand' -a copy -d "Copy containers within or in between lxd instances"
complete -c lxc -f -n '__fish_lxc_no_subcommand' -a delete -d "Delete containers or container snapshots"
complete -c lxc -f -n '__fish_lxc_no_subcommand' -a exec -d "Execute the specified command in a container"
complete -c lxc -f -n '__fish_lxc_no_subcommand' -a file -d "Manage files on a container"
complete -c lxc -f -n '__fish_lxc_no_subcommand' -a help -d "Presents details on how to use LXD"
complete -c lxc -f -n '__fish_lxc_no_subcommand' -a image -d "Manipulate container images"
complete -c lxc -f -n '__fish_lxc_no_subcommand' -a info -d "List information on LXD servers and containers"
complete -c lxc -f -n '__fish_lxc_no_subcommand' -a launch -d "Launch a container from a particular image"
complete -c lxc -f -n '__fish_lxc_no_subcommand' -a list -d "Lists the available resources"
complete -c lxc -f -n '__fish_lxc_no_subcommand' -a move -d "Move containers within or in between lxd instances"
complete -c lxc -f -n '__fish_lxc_no_subcommand' -a profile -d "Manage configuration profiles"
complete -c lxc -f -n '__fish_lxc_no_subcommand' -a publish -d "Publish containers as images"
complete -c lxc -f -n '__fish_lxc_no_subcommand' -a remote -d "Manage remote LXD servers"
complete -c lxc -f -n '__fish_lxc_no_subcommand' -a restart -d "Changes state of one or more containers to restart"
complete -c lxc -f -n '__fish_lxc_no_subcommand' -a restore -d "Set the current state of a resource back to a snapshot"
complete -c lxc -f -n '__fish_lxc_no_subcommand' -a snapshot -d "Create a read-only snapshot of a container"
complete -c lxc -f -n '__fish_lxc_no_subcommand' -a start -d "Changes state of one or more containers to start"
complete -c lxc -f -n '__fish_lxc_no_subcommand' -a stop -d "Changes state of one or more containers to stop"
complete -c lxc -f -n '__fish_lxc_no_subcommand' -a version -d "Prints the version number of this client tool"

complete -c lxc -A -f -n '__fish_seen_subcommand_from exec'    -a '(__fish_print_lxc_containers running)' -d "Running"
complete -c lxc -A -f -n '__fish_seen_subcommand_from restart' -a '(__fish_print_lxc_containers running)' -d "Running"
complete -c lxc -A -f -n '__fish_seen_subcommand_from stop'    -a '(__fish_print_lxc_containers running)' -d "Running"
complete -c lxc -A -f -n '__fish_seen_subcommand_from start'   -a '(__fish_print_lxc_containers stopped)' -d "Stopped"

complete -c lxc -f -n '__fish_lxc_config_subcommand' -a device -d "Config for Device"
complete -c lxc -f -n '__fish_lxc_config_subcommand' -a get    -d "Get container or server configuration key"
complete -c lxc -f -n '__fish_lxc_config_subcommand' -a set    -d "Set container or server configuration key"
complete -c lxc -f -n '__fish_lxc_config_subcommand' -a unset  -d "Unset container or server configuration key"
complete -c lxc -f -n '__fish_lxc_config_subcommand' -a trust  -d "Manage trusting certs/hosts"
