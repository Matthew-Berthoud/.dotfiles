#!/bin/bash

set -e # Exit if any command fails

DOTFILES="$HOME/.dotfiles"
cd "$DOTFILES"

# Functions
open_or_print_link() {
    if [ "$(uname)" == "Darwin" ]; then
	open -g $1 # opens in background
	echo "Check your browser."
    else
	echo "Here's the link: $1"
    fi
}
prompt_go_install() {
    echo "Wanna install Go?"
    open_or_print_link 'https://go.dev/doc/install'
}

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
if [ "$(uname)" == "Darwin" ]; then
    # Install Homebrew if not already
    if ! which brew &>/dev/null; then
    	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    else
	echo "Homebrew already installed"
    fi
    cd "$DOTFILES"
    # Install what's in the Brewfile and remove any brew stuff that isn't in Brewfile
    brew bundle --force cleanup --file=Brewfile
fi

# Set default editor to nvim if it exists. Otherwise set to vim
command -v nvim >/dev/null 2>&1 && export EDITOR=nvim || export EDITOR=vim

# Install latest LTS version of Node if nvm exists
command -v nvm >/dev/null 2>&1 && nvm install --lts --latest-npm

# Notify that the user must install Go if it's not there
command -v go >/dev/null 2>&1 || prompt_go_install

