#!/bin/bash

if [[ "$(uname)" == "Darwin" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"

    # Annoying "zsh is the default shell now, switch to it" type warning
    export BASH_SILENCE_DEPRECATION_WARNING=1
fi

if [[ "$(uname -s)" == "Linux" ]]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# nvm (node version manager)
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

if [ -f $DOTFILES/scripts/git-completion.bash ]; then
  . $DOTFILES/scripts/git-completion.bash
fi

source ~/.bashrc

