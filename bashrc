#!/bin/bash

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

DOT_DIR=$HOME/.dotfiles
for DOT_FILE in "$DOT_DIR"/system/.{function,alias,prompt,pyenv}; do
    . "$DOT_FILE"
done

