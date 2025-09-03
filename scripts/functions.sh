#!/bin/bash

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

    user="${magenta}\u${reset}"
    host="${yellow}\h${reset}"
    dir="${cyan}\w${reset}"

    if [ -n "${CONTAINER_HOSTNAME}" ]; then
        host="${yellow}$CONTAINER_HOSTNAME${reset}"
    fi
    echo "${user}@${host}:${dir}\$ "
}

rm_DS_Store_and_dir() {
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

navigate_to_port() {
    # open app in the background
    open -g -a Safari "localhost:$1"
}

make_project_zip() {
    project="$1"
    project_folder="$HOME/repos/Distributed-System-Security/Projects/$project/"

    cd $project_folder && make clean && zip -r $project.zip *
    mv $project.zip $HOME/Downloads/
}

work() {
    # WARNING: If you have more than one of these where "attach" is not set to false,
    # (true is the default) then they will open in series, so you'll only open the
    # first session, and then when you close it fully the next will open, etc.

    tmuxinator start -p ~/.config/tmuxinator/dotfiles.yml
    tmuxinator start -p ~/.config/tmuxinator/notes.yml
    tmuxinator start -p ~/.config/tmuxinator/ndaa.yml
}

home() {
    # WARNING: (see warning in `work` function)

    tmuxinator start -p ~/.config/tmuxinator/dotfiles.yml
    tmuxinator start -p ~/.config/tmuxinator/site.yml
}
