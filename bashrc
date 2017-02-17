if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

complete -cf sudo
stty stop undef
