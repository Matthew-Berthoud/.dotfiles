#!/bin/bash

echo "Running .bash_profile"

if [[ "$(uname)" == "Darwin" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"

    # nvm (node version manager)
    export NVM_DIR="$HOME/.nvm"
    mkdir -p "$NVM_DIR"
    [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"                                       # This loads nvm
    [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion

    # Annoying "zsh is the default shell now, switch to it" type warning
    export BASH_SILENCE_DEPRECATION_WARNING=1

    # Added by LM Studio CLI (lms)
    export PATH="$PATH:/Users/matthewberthoud/.lmstudio/bin"
    # End of LM Studio CLI section

    # rust
    . "$HOME/.cargo/env"

    # Added by `rbenv init` on Sat Oct 25 00:54:49 EDT 2025
    eval "$(rbenv init - --no-rehash bash)"

    # sdkman-cli from brew
    if command -v brew >/dev/null 2>&1 && brew list sdkman-cli >/dev/null 2>&1; then
        export SDKMAN_DIR="$(brew --prefix sdkman-cli)/libexec"
        if [ -s "${SDKMAN_DIR}/bin/sdkman-init.sh" ]; then
            source "${SDKMAN_DIR}/bin/sdkman-init.sh"
        fi
    fi

elif [[ "$(uname -s)" == "Linux" ]]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

    [ -s "/home/linuxbrew/.linuxbrew/opt/nvm/nvm.sh" ] && \. "/home/linuxbrew/.linuxbrew/opt/nvm/nvm.sh"                                       # This loads nvm
    [ -s "/home/linuxbrew/.linuxbrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/home/linuxbrew/.linuxbrew/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion

    # Only run in WSL
    if grep -qi "microsoft" /proc/version; then
        # check if kmonad.exe is already running
        if ! pgrep -f "kmonad.exe" >/dev/null; then
            nohup "$DOTFILES/kmonad/windows/kmonad.exe" \
                "$DOTFILES/kmonad/windows/config.kbd" \
                >/dev/null 2>&1 &
            echo "kmonad.exe started."
        else
            echo "kmonad.exe already running."
        fi
    fi

else
    echo "⚠️ Operating system is not Unix-based"
fi

source ~/.bashrc
