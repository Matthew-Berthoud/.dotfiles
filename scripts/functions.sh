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

    echo "${magenta}\u${reset}@${yellow}\h${reset}:${cyan}\w${reset}\$ "
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
    open -a Safari "localhost:$1"
}

