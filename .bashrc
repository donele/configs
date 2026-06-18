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

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
[ -d "${DOT_DIR}/python" ] && export PATH="${PATH}:${DOT_DIR}/python"
[ -d "${DOT_DIR}/scripts" ] && export PATH="${PATH}:${DOT_DIR}/scripts"
[ -d "/home/jdlee/.foundry/bin" ] && export PATH="${PATH}:/home/jdlee/.foundry/bin"
. "$HOME/.cargo/env"
ulimit -S -n 1048576 2>/dev/null
