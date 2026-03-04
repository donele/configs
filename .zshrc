DOT_DIR=$HOME/.dotfiles
if [ -d "$HOME/repos/configs" ]; then
    DOT_DIR="$HOME/repos/configs"
fi

for DOT_FILE in "$DOT_DIR"/system/.{exports,function,alias,prompt_zsh}; do
    . "$DOT_FILE"
done

export PATH=${PATH}:${DOT_DIR}/python
