os_name=$(uname -s)
if [ "$os_name" = "Darwin" ]; then
# Mac OS
    # no hostname on local machine, just current dir
    PS1="(\W) "

else
    # Linux OS
    export PATH="/home/bren/Software/sim/misc/yas:$PATH"
    export PATH="/home/bren/Software/sim/misc/yis:$PATH"

    # show hostname when on linux machines
    PS1="\h(\W) "
fi


# vim mode for terminal
set -o vi

# Most of my aliases (more at bottom)
alias e="exit"
alias c="clear"

alias ch="open -a Google\ Chrome"
alias lt="latexmk -pdf -pvc"

alias ..="cd .."
alias ~="cd ~"
alias b="cd -"

alias dt="cd ~/Desktop"
alias dl="cd ~/Downloads"
alias dc="cd ~/Documents"

alias dot="cd ~/dotfiles"
alias sb="cd ~/second-brain"
alias one="cd ~/onedrive"
alias r="cd ~/repositories"
alias gdsc="cd ~/repositories/gdsc"
alias fh="code ~/repositories/gdsc/flat-hat-games/wp-plugin"

alias ls="ls --color=auto"
alias la="ls -lah"
alias lg="la | grep"

alias t=tmux
alias v=vim
alias vr="v ~/.vimrc"
alias br="v ~/.bashrc"
alias bp="v ~/.bash_profile"
alias re="source ~/.bashrc"

alias g=git
alias gl="git pull"
alias gs="git status"
alias ga="git add ."
alias gc="git commit -m"
alias gp="git push"

alias ss="mv ~/Desktop/Screen* ./"

# Use this to randomly select a machine, hopefully a fast one
# For all other ssh stuff use Host names in .ssh/config
sshlab () {
    ssh mwberthoud@th121-$((1 + RANDOM % 24)).cs.wm.edu
}

econ () {
    cd /Users/matthewberthoud/onedrive/courses/econ/$1
    pwd
}

cs () {
    cd /Users/matthewberthoud/onedrive/courses/cs/$1
    pwd
}

lazygit() {
    echo "********** GIT PULL **********"
    gl
    echo "********** GIT ADD ***********"
    ga 
    echo "********* GIT COMMIT *********"
    gc "$1 lazycommit"
    echo "********** GIT PUSH **********"
    gp
}

# move only image on desktop to current directory
img() {
    desktop="~/Desktop"
    img_names=$(find ~/Desktop -maxdepth 1 -type f -name "*.png")
    # expand this reg exp eventually to consider more filetypes
    img_count=$("$img_names" | wc -l)
    if [ "$img_count" -eq 1 ]; then
        echo Moving image $(img_names) to $(pwd)
    elif [ "$count" -eq 0 ]; then
        echo "There are no images on Desktop." 
        return
    else
        echo "There are $(count) images on Desktop. Aborting."
        return
    fi

    directory="."
    files=$(ls "$directory")
    
    # Initialize variables to store the highest number
    highest_number=0
    
    # Loop through each file
    for file in $files; do
        # Check if the file starts with "img-" followed by a number and has a file extension
        if [[ $file =~ ^img-([0-9]+)\..+$ ]]; then
            number="${BASH_REMATCH[1]}"
            # Compare the number with the highest_number
            if (( number > highest_number )); then
                highest_number=$number
            fi
        fi
    done

    new_num=$highest_number + 1
    # update this with more than png when you need to
    mv "$img_names" "$directory/img-$new_num.png"
}

rm_DS_Store_dir () {

    output=$(rmdir $1 2>&1)
    if [ $? -eq 0 ]; then
        return
    fi

    last_three_words=$(echo "$output" | awk '{print $(NF-2), $(NF-1), $NF}')
    if [ "$last_three_words" != "Directory not empty" ]; then
        echo $output
        return
    fi

    contents=$(ls -a $1 | sort)
    expected_contents=$(echo -e ".\n..\n.DS_Store" | sort)
    if [ "$contents" != "$expected_contents" ]; then
        echo $output
        return
    fi

    rm "$1/.DS_Store"
    if [ $? -ne 0 ]; then
        echo Failed to remove "$1/.DS_Store". Aborting
        return
    fi

    rmdir $1
    if [ $? -eq 0 ]; then
        echo Removed $1/.DS_Store file and $1 directory
    else
        echo Failed to remove $1 directory, but successfully removed $1/.DS_Store
    fi
}

newrepo () {
    if [ -e ".git" ]; then
        echo "This is already a Git repository"
        exit 1
    fi

    git init
    git add *
    git commit -m "initial"
    gh repo create $(basename "$PWD") --private --source=. --remote=origin
    git push --set-upstream origin main
}

alg () {
    cs 653
    echo Analysis of Algorithms
}

swe () {
    cs 535
    echo Software Engineering
}

sec () {
    cs 667
    echo Concepts of Computer Security
}

mic () {
    cs 780
    echo Advanced Microarchitecture Security
}

cyb () {
    cs 564
    echo Applied Cybersecurity
}

todo () {
    sb
    v README.md
}

# Aliases for functions defined above
alias lazy="lazygit"
alias rmdirr="rm_DS_Store_dir"

alias repocheck="la -R | grep git"

eval "$(pyenv init --path)"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
