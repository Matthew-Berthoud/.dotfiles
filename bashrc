export DOTFILES=$HOME/.dotfiles
export SCRIPTS=$HOME/.dotfiles/scripts
export DOCKER_HOST=unix:///Users/$USER/.colima/default/docker.sock
command -v nvim >/dev/null 2>&1 && export EDITOR=nvim || export EDITOR=vim

source "$SCRIPTS/functions.sh"

set -o vi

PS1=$(colorful_ps1)

alias dot="cd $DOTFILES"
alias rundot="/bin/bash $SCRIPTS/install.sh"
alias rmdirr="rm_DS_Store_and_dir"
alias nav="navigate_to_port"
alias ddev="bash $DOTFILES/docker-dev/launch.sh"

command -v nvim >/dev/null 2>&1 && alias vim="nvim"




# temporary, project-specific
alias fhg="nav 5173 && ddev react 5173 5173"
alias fhgp="cd $HOME/Desktop/flat-hat-games-wp-plugin/ && docker compose up -d && nav '8000/wp-admin/admin.php?page=flathat-games'"
alias gs="make_project_zip sodoh"

