#!/bin/bash

if [[ "$(uname)" == "Darwin" ]]; then

    # Annoying "zsh is the default shell now, switch to it" type warning
	export BASH_SILENCE_DEPRECATION_WARNING=1

    # Homebrew on path
    eval "$(/opt/homebrew/bin/brew shellenv)"

    # Go on path
    export PATH=$PATH:/usr/local/go/bin

    # nvm (node version manager)
    export NVM_DIR="$HOME/.nvm"
    [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
    [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

fi

if [ -f $DOTFILES/scripts/git-completion.bash ]; then
  . $DOTFILES/scripts/git-completion.bash
fi

source ~/.bashrc

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/matthewberthoud/.lmstudio/bin"
# End of LM Studio CLI section

