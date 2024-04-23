# bash_profile runs on login, bashrc runs when shell opened? 
PS1="(\W) "

sshlab () {
    ssh mwberthoud@th121-$((1 + RANDOM % 24)).cs.wm.edu
}

scplab () {
    scp $1 mwberthoud@th121-3.cs.wm.edu:/home/mwberthoud/
}

scpfromlab() {
    scp mwberthoud@th121-3.cs.wm.edu:/home/mwberthoud/$1 ./
}


econ () {
    cd /Users/matthewberthoud/Documents/ECON_$1/
}

cs () {
    cd /Users/matthewberthoud/Documents/CSCI_$1/
}

notes () {
    if [ "$1" = "461" ]; then
        econ $1
    else
        cs $1
    fi
}

lazygit () {
    git pull
    git add *
    git commit -m $1
    git push
}


alias re="source ~/.bashrc"

alias dt="cd ~/Desktop"
alias sb="second_brain"
alias dl="cd ~/Downloads"
alias dc="cd ~/Documents"
alias ..="cd .."

alias ls='ls --color=auto'
alias ll='ls -la'
alias la='ls -lathr'

alias v=vim
alias t=tmux
alias g=git
alias gs="git status"
alias ga="git add"
alias gc="git commit -m"
alias lg="lazygit"

clear
