#!/bin/bash

echo "Running .bashrc"

export EDITOR='nvim'
export PATH=$PATH:$(go env GOPATH)/bin

export REPOS=$HOME/repos
export PERSONAL_REPOS=$REPOS/personal
export WORK_REPOS=$REPOS/black-cape
export DOTFILES=$HOME/.dotfiles
export SCRIPTS=$DOTFILES/scripts
export AUTO_TMUX=$DOTFILES/auto-tmux

set -o vi

source "$SCRIPTS/functions.sh"
source "$SCRIPTS/git-completion.bash"
source "$SCRIPTS/git-prompt.sh"
BLUE='\[\e[0;34m\]'
RESET='\[\e[0m\]'
PROMPT_COMMAND='__git_ps1 "${BLUE}\W${RESET}" "\\\$ "'

alias ls="ls --color"
alias la="ls -lah --color"

alias dot="cd $DOTFILES"
alias dotrun="bash $SCRIPTS/install.sh && source $HOME/.bash_profile"
alias dotgit="dotgit"
alias nav="navigate_to_port"
alias treedme="tree -a --gitignore --dirsfirst -I ".git/" --noreport | pbcopy"
alias cssbattle="pbpaste | python $SCRIPTS/cssbattle_condenser.py | pbcopy"
alias love="/Applications/love.app/Contents/MacOS/love"

alias v="nvim"
alias vi="nvim"
alias vim="nvim"

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"

# On my Mac only
if [ "$(uname)" == "Darwin" ]; then
  alias rmdirr="rm_DS_Store_and_dir"
  alias ddev="bash $DOTFILES/docker-dev/launch.sh"
fi

# Load machine-specific settings if they exist
if [[ -f ~/.bash_profile.local ]]; then
  source ~/.bash_profile.local
fi

export IGNOREEOF=10
. "$HOME/.cargo/env"

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/matthewberthoud/.lmstudio/bin"
# End of LM Studio CLI section
