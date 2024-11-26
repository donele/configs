DOT_DIR=$HOME/.dotfiles
for DOT_FILE in "$DOT_DIR"/system/.{function,alias,prompt}; do
    . "$DOT_FILE"
done

