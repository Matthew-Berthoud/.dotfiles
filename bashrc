export DOTFILES=$HOME/.dotfiles
export SCRIPTS=$HOME/.dotfiles/scripts

colorful_ps1() {
    reset='\[\033[0m\]'
    black='\[\033[30m\]'
    red='\[\033[31m\]'
    green='\[\033[32m\]'
    yellow='\[\033[33m\]'
    blue='\[\033[34m\]'
    magenta='\[\033[35m\]'
    cyan='\[\033[36m\]'
    white='\[\033[37m\]'

    echo "${magenta}\u${reset}@${yellow}\h${reset}:${cyan}\w${reset}\$ "
}

PS1=$(colorful_ps1)
# PS1="\u@\h:\w \$ "

# Vim keybindings for command-line
set -o vi

alias rmdirr="source $SCRIPTS/rmdir_and_DS_Store.sh"
alias ddev="bash $DOTFILES/docker-dev/launch.sh"

