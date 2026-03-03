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

for DOT_FILE in "$DOT_DIR"/system/.{exports,function,function_122,alias,prompt_bash,pyenv}; do
    . "$DOT_FILE"
done

export PATH=${PATH}:${DOT_DIR}/python
