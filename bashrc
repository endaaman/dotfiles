if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

complete -cf sudo
stty stop undef

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/ken/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/ken/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/ken/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/ken/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

