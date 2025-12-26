#!/bin/bash

DOTFILES="$HOME/.dotfiles"
cd "$DOTFILES"

FILES_TO_LINK=("bash_profile" "bashrc" "vimrc" "gitconfig" "gitconfig-work")
for FILE in "${FILES_TO_LINK[@]}"; do
  ln -sf "$DOTFILES/$FILE" "$HOME/.$FILE"
done
echo "Sym-linked these dotfiles: ${FILES_TO_LINK[*]}"

CONFIG_DIRS=("nvim" "tmux" "ghostty" "karabiner" "aerospace")
for DIR in "${CONFIG_DIRS[@]}"; do
  rm -rf "$HOME/.config/$DIR"
  ln -sf "$DOTFILES/$DIR" "$HOME/.config/$DIR"
done
echo "Sym-linked these config directories: ${CONFIG_DIRS[*]}"

# Install Homebrew if not already
if ! which brew &>/dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

brew bundle install --file="$DOTFILES/Brewfile" --cleanup

# Install latest LTS version of Node if nvm exists
command -v nvm >/dev/null 2>&1 && nvm install --lts --latest-npm

# Install latest Python 3.11 LTS if pyenv exists
if command -v pyenv >/dev/null 2>&1; then
  LATEST_LTS=$(pyenv install --list | grep -E '^\s*3\.11\.[0-9]+$' | tail -1 | tr -d ' ')
  pyenv install -s "$LATEST_LTS"
  pyenv global "$LATEST_LTS"
fi

# Pull in submodules of this repo (eg. nvim)
# cd "$DOTFILES" && git submodule init && git pull --recurse-submodule && cd - >/dev/null 2>&1

# install rust
command -v rustc >/dev/null 2>&1 || curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf | sh
