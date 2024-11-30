DOT_DIR=$HOME/.dotfiles
if [ -d "$HOME/repos/configs" ]; then
    DOT_DIR="$HOME/repos/configs"
fi

for DOT_FILE in "$DOT_DIR"/system/.{function,alias,prompt}; do
    . "$DOT_FILE"
done

