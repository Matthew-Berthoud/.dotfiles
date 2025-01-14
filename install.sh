#!/bin/bash

# Exit if any command fails
set -e

DOTFILES="$HOME/.dotfiles"
BASH_STARTUP_FILES=("bash_profile" "bashrc")

for FILE in "${BASH_STARTUP_FILES[@]}"; do
	ln -si "$DOTFILES/$FILE" "$HOME/.$FILE"
	source "$HOME/.$FILE"
done

