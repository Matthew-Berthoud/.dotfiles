#!/bin/bash

echo "Running .bash_profile"

if [[ "$(uname)" == "Darwin" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"

    [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
    [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

    # Annoying "zsh is the default shell now, switch to it" type warning
    export BASH_SILENCE_DEPRECATION_WARNING=1

    # Added by LM Studio CLI (lms)
    export PATH="$PATH:/Users/matthewberthoud/.lmstudio/bin"
    # End of LM Studio CLI section

elif [[ "$(uname -s)" == "Linux" ]]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

    [ -s "/home/linuxbrew/.linuxbrew/opt/nvm/nvm.sh" ] && \. "/home/linuxbrew/.linuxbrew/opt/nvm/nvm.sh"  # This loads nvm
    [ -s "/home/linuxbrew/.linuxbrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/home/linuxbrew/.linuxbrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

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
fi

# nvm (node version manager)
export NVM_DIR="$HOME/.nvm"
mkdir -p "$NVM_DIR"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

if [ -f $DOTFILES/scripts/git-completion.bash ]; then
  . $DOTFILES/scripts/git-completion.bash
fi

source ~/.bashrc

. "$HOME/.cargo/env"
