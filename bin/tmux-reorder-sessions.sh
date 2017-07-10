#!/usr/bin/env bash

sessions=$(tmux ls | grep -E '^[0-9]*:' | cut -f1 -d':' | sort)

new=0
for old in $sessions
do
  tmux rename -t $old $new
  ((new++))
done
