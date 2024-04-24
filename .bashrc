PS1="(\W) "

# Use this to randomly select a machine, hopefully a fast one
# For all other ssh stuff use Host names in .ssh/config
sshlab () {
    ssh mwberthoud@th121-$((1 + RANDOM % 24)).cs.wm.edu
}

econ () {
    cd /Users/matthewberthoud/Documents/ECON_$1/
}

cs () {
    cd ~/Documents/CSCI_$1/
}

notes () {
    if [ "$1" = "461" ]; then
        econ $1
    else
        cs $1
    fi
    if [ -d "notes" ]; then
        cd notes
    fi
    if [ -f "notes.md" ]; then
        v notes.md
    fi
}

docs () {
    case $1 in
        sh | bash) ch https://www.gnu.org/savannah-checkouts/gnu/bash/manual/bash.html;;
        *) echo No documentation linked for $1;;
    esac
}

lazygit() {
    g pull
    ga "$@"
    gc "lazy"
    g push
}

# personalized help function that shows my notes
h() {
    case $1 in
        git | g) case $2 in 
            branch) 
                echo "New branch:    g checkout -b <name>"
                echo "               g branch <name> (doesn't switch to it)"
                echo "First push:    g push -u origin"
            ;;
            *)  echo "Specify an option: branch, etc.";;
        esac ;;
        *) echo No helpdoc written for $1;;
    esac

}


alias ch="open -a Google\ Chrome"

alias dot="cd ~/dotfiles"
alias dt="cd ~/Desktop"
alias sb="cd ~/Desktop/second_brain"
alias dl="cd ~/Downloads"
alias dc="cd ~/Documents"
alias ..="cd .."

alias ls="ls --color=auto"
alias ll="ls -la"
alias la="ls -lathr"
alias lg="la | grep"

alias t=tmux
alias v=vim
alias vr="v ~/.vimrc"
alias br="v ~/.bashrc"
alias bp="v ~/.bash_profile"
alias re="source ~/.bashrc"

alias g=git
alias gs="git status"
alias ga="git add"
alias gc="git commit -m"
alias lazy="lazygit"
