#!/bin/bash

# Exit if any command fails
set -e

DOTFILES="$HOME/.dotfiles"
FILES_TO_LINK=("bash_profile" "bashrc" "vimrc")

for FILE in "${FILES_TO_LINK[@]}"; do
	ln -si "$DOTFILES/$FILE" "$HOME/.$FILE"
done

source ~/.bash_profile

