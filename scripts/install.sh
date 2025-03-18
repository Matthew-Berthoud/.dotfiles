#!/bin/bash

# Exit if any command fails
set -e

DOTFILES="$HOME/.dotfiles"
cd "$DOTFILES"

FILES_TO_LINK=("bash_profile" "bashrc" "screenrc" "vimrc")
for FILE in "${FILES_TO_LINK[@]}"; do
	ln -si "$DOTFILES/$FILE" "$HOME/.$FILE"
done

CONFIG_DIRS=("nvim")
for DIR in "${CONFIG_DIRS[@]}"; do
    ln -si "$DOTFILES/$DIR" "$HOME/.config/$DIR"
done

