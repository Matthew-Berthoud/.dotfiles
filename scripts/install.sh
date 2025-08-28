#!/bin/bash

DOTFILES="$HOME/.dotfiles"
cd "$DOTFILES"

# Functions
handle_error() {
    local exit_code=$?
    local command="$BASH_COMMAND"
    echo "Error: Command '$command' failed with exit code $exit_code" >&2
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
do_brew() {
    # Install Homebrew if not already
    if ! which brew &>/dev/null; then
    	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    # Install Mac developer tools that Brew depends on
    # install_xcode_tools
    
    # Remove anything installed with brew that isn't in the current Brewfile
    # brew bundle --force cleanup --file=Brewfile


    # --- SHARED BUNDLE ---
    local shared="$DOTFILES/brew/Brewfile"
    echo "Brew Bundling from $shared"
    brew bundle --file "$shared"

    # --- WORK OR PERSONAL BUNDLE ---

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
        echo "💻 Brew Bundling from $work (Work Computer)"
        brew bundle --file "$work"
    else
        local personal="$DOTFILES/brew/personal.Brewfile"
        echo "🏠 Brew Bundling from $personal (Personal Computer)"
        brew bundle --file "$personal"
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

# Mac only
if [ "$(uname)" == "Darwin" ]; then
    do_brew
fi

open -g -a Tailscale

# Install latest LTS version of Node if nvm exists
command -v nvm >/dev/null 2>&1 && nvm install --lts --latest-npm

# Install Go?
command -v go >/dev/null 2>&1 && echo "Go already installed" || prompt_go_install
