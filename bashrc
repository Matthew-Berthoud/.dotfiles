export DOTFILES=$HOME/.dotfiles
export SCRIPTS=$HOME/.dotfiles/scripts

source "$SCRIPTS/functions.sh"

set -o vi

PS1=$(colorful_ps1)

alias rmdirr="rm_DS_Store_and_dir"
alias ddev="bash $DOTFILES/docker-dev/launch.sh"
alias fhg="ddev react 5173 5173"
alias nav="navigate_to_port"

