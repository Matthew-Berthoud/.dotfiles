#!/bin/bash

DOTFILES="$HOME/.dotfiles"
cd "$DOTFILES"

get_brew_packages() {
    # --- SHARED BUNDLE ---
    local shared="$DOTFILES/brew/Brewfile"
    echo "Brew Bundling from $shared"
    brew bundle --file "$shared"

    # --- WORK BUNDLE ---

    # Determine the correct local file based on the user's shell.
    # We default to a generic .profile.local if we can't determine the shell.
    local local_env_file="$HOME/.profile.local"
    if [[ "$SHELL" == *"zsh"* ]]; then
        local_env_file="$HOME/.zshrc.local"
    elif [[ "$SHELL" == *"bash"* ]]; then
        local_env_file="$HOME/.bash_profile.local"
    fi

    # Source the local file if it exists, to load the WORK_COMPUTER variable.
    if [[ -f "$local_env_file" ]]; then
        source "$local_env_file"
    fi

    # Now, check if the variable is set. If not, ask the user and create the file.
    if [[ -z "$WORK_COMPUTER" ]]; then
        echo "First-time setup: Let's determine the computer type."
        read -p "Is this a work computer? (y/n) " -n 1 -r
        echo # New line

        local is_work_computer=false
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            is_work_computer=true
        fi

        echo "Saving your preference to $local_env_file..."
        # Create or overwrite the local file with the machine-specific setting.
        # Using a single '>' ensures the file is clean if this script is ever re-run.
        echo "# Do not commit this file. It is for machine-specific settings." > "$local_env_file"
        echo "export WORK_COMPUTER=$is_work_computer" >> "$local_env_file"

        # Set the variable for the CURRENT session so the script can complete.
        export WORK_COMPUTER=$is_work_computer

        echo "✅ Preference saved. You won't be asked this again on this machine."
    fi

    # Use the WORK_COMPUTER variable to run the correct bundle.
    if [[ "$WORK_COMPUTER" == "true" ]]; then
        local work="$DOTFILES/brew/work.Brewfile"
        echo "💻 Brew Bundling $work (Work Computer)"
        brew bundle --file "$work"
    fi
}

FILES_TO_LINK=("bash_profile" "bashrc" "vimrc")
for FILE in "${FILES_TO_LINK[@]}"; do
	ln -sf "$DOTFILES/$FILE" "$HOME/.$FILE"
done
echo "Sym-linked these dotfiles: ${FILES_TO_LINK[*]}"

CONFIG_DIRS=("nvim" "tmux" "ghostty" "karabiner" "tmuxinator")
for DIR in "${CONFIG_DIRS[@]}"; do
    rm -rf "$HOME/.config/$DIR"
    ln -sf "$DOTFILES/$DIR" "$HOME/.config/$DIR"
done
echo "Sym-linked these config directories: ${CONFIG_DIRS[*]}"

# Install Homebrew if not already
if ! which brew &>/dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

get_brew_packages

# Install latest LTS version of Node if nvm exists
command -v nvm >/dev/null 2>&1 && nvm install --lts --latest-npm

# Install latest Python 3.11 LTS if pyenv exists
if command -v pyenv >/dev/null 2>&1; then
    LATEST_LTS=$(pyenv install --list | grep -E '^\s*3\.11\.[0-9]+$' | tail -1 | tr -d ' ')
    pyenv install -s "$LATEST_LTS"
    pyenv global "$LATEST_LTS"
fi

# Pull in submodules of this repo (eg. nvim)
cd "$DOTFILES" && git submodule init && git pull --recurse-submodule && cd - > /dev/null 2>&1

# install rust
command -v rustc >/dev/null 2>&1 || curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf | sh

source ~/.bash_profile
