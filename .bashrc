#!/bin/bash

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

DOT_DIR=$HOME/.dotfiles
if [ "$CODER" == "true" ]; then
    DOT_DIR=$HOME/.config/coderv2/dotfiles
elif [ -d "$HOME/repos/configs" ]; then
    DOT_DIR="$HOME/repos/configs"
fi

for DOT_FILE in "$DOT_DIR"/system/.{function,alias,prompt,pyenv}; do
    . "$DOT_FILE"
done

