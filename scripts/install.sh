#!/bin/bash

# Exit if any command fails
set -e

DOTFILES="$HOME/.dotfiles"
cd "$DOTFILES"

FILES_TO_LINK=("bash_profile" "bashrc")
for FILE in "${FILES_TO_LINK[@]}"; do
	ln -sf "$DOTFILES/$FILE" "$HOME/.$FILE"
done

CONFIG_DIRS=("nvim" "tmux")
for DIR in "${CONFIG_DIRS[@]}"; do
    rm -rf "$HOME/.config/$DIR"
    ln -sf "$DOTFILES/$DIR" "$HOME/.config/$DIR"
done

