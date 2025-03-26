export DOTFILES=$HOME/.dotfiles
export SCRIPTS=$HOME/.dotfiles/scripts
export DOCKER_HOST=unix:///Users/$USER/.colima/default/docker.sock

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
    alias vim="nvim"

    alias rmdirr="rm_DS_Store_and_dir"
    alias ddev="bash $DOTFILES/docker-dev/launch.sh"

    # temporary, project-specific
    alias fhg="nav 5173 && ddev react 5173 5173"
    alias fhgp="cd $HOME/Desktop/flat-hat-games-wp-plugin/ && docker compose up -d && nav '8000/wp-admin/admin.php?page=flathat-games'"
    alias gs="make_project_zip sodoh"
    export KO_DOCKER_REPO='ko.local'
fi
