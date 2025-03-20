#!/bin/bash

DOTFILES="$HOME/.dotfiles"
cd "$DOTFILES"

# Functions
handle_error() {
    local exit_code=$?
    local command="$BASH_COMMAND"
    echo "Error: Command '$command' failed with exit code $exit_code" >&2
    exit $exit_code
}
install_xcode_tools() {
    # Check if Xcode CLT are installed
    if ! xcode-select -p &>/dev/null; then
        echo "Starting Xcode Command Line Tools installation..."
        xcode-select --install
    
        # Wait for installer process to exit (user clicks "Done")
        echo "Monitoring installer progress..."
        while pgrep -q "Install Command Line Developer Tools"; do
            sleep 5
            echo "Installer still running..."
        done
    
        # Verify actual installation completion
        echo "Verifying system components..."
        until [ -f /Library/Developer/CommandLineTools/usr/bin/git ] && 
              [ -d /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk ]; do
            sleep 5
            echo "Waiting for components to become available..."
        done
    
        echo "Xcode CLT installation fully completed"
    else
        echo "Xcode Command Line Tools already installed"
    fi
}
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

trap 'handle_error' ERR

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

    # Install Mac developer tools that Brew depends on
    install_xcode_tools

    # Install what's in the Brewfile and remove any brew stuff that isn't in Brewfile
    brew bundle --force cleanup --file=Brewfile

    # Install Tailscale
    if [ -e "/Applications/Tailscale.app" ]; then
        echo "Tailscale already installed"
    else
	echo "Downloading Tailscale. Go to Finder and double click the .pkg file"
	wget -P "$HOME/Downloads" https://pkgs.tailscale.com/stable/Tailscale-latest-macos.pkg
	open -g -a "Finder" "$HOME/Downloads"
    fi
fi

# Install latest LTS version of Node if nvm exists
command -v nvm >/dev/null 2>&1 && nvm install --lts --latest-npm

# Install Go?
command -v go >/dev/null 2>&1 && echo "Go already installed" || prompt_go_install
