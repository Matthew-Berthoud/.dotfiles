#!/bin/bash

# Exit if any command fails
set -e

DOTFILES="$HOME/.dotfiles"
cd "$DOTFILES"

FILES_TO_LINK=("bash_profile" "bashrc")
for FILE in "${FILES_TO_LINK[@]}"; do
	ln -sf "$DOTFILES/$FILE" "$HOME/.$FILE"
done
echo "Sym-linked these dotfiles: ${FILES_TO_LINK[*]}"

CONFIG_DIRS=("nvim" "tmux")
for DIR in "${CONFIG_DIRS[@]}"; do
    rm -rf "$HOME/.config/$DIR"
    ln -sf "$DOTFILES/$DIR" "$HOME/.config/$DIR"
done
echo "Sym-linked these config directories: ${CONFIG_DIRS[*]}"

# Mac only
if [[ "$(uname)" == "Darwin" ]]; then
    # Install Homebrew if not already
    if ! which brew &>/dev/null; then
    	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    else
	echo "Homebrew already installed"
    fi
    cd "$DOTFILES"
    brew bundle
fi



