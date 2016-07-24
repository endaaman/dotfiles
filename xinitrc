#!/bin/bash

if ! which git >/dev/null 2>&1; then
  if [ -f ~/.Xmodmap ]; then
    xmodmap ~/.Xmodmap
  fi
fi
