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
    cd ~/Documents/CSCI_$1/
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
alias re="source ~/.bash_profile"

alias g=git
alias gs="git status"
alias ga="git add"
alias gc="git commit -m"
