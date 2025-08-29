export EDITOR='nvim'
export DOTFILES=$HOME/.dotfiles
export SCRIPTS=$HOME/.dotfiles/scripts
export DOCKER_HOST=unix:///Users/$USER/.colima/default/docker.sock
export PATH=$PATH:$(go env GOPATH)/bin

source "$SCRIPTS/functions.sh"

set -o vi

PS1=$(colorful_ps1)

alias ls="ls --color"
alias la="ls -lah --color"

alias dot="cd $DOTFILES"
alias rundot="/bin/bash $SCRIPTS/install.sh"
alias nav="navigate_to_port"

# On my Mac only
if [ "$(uname)" == "Darwin" ]; then
    alias v="nvim"
    alias vi="nvim"
    alias vim="nvim"

    alias rmdirr="rm_DS_Store_and_dir"
    alias ddev="bash $DOTFILES/docker-dev/launch.sh"

    # pyenv initialization
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init --path)"
    eval "$(pyenv init -)"
fi

# Load machine-specific settings if they exist
if [[ -f ~/.bash_profile.local ]]; then
  source ~/.bash_profile.local
fi

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/matthewberthoud/.lmstudio/bin"
# End of LM Studio CLI section

