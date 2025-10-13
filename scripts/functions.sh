#!/bin/bash

colorful_ps1() {
    reset='\[\033[0m\]'
    black='\[\033[30m\]'
    red='\[\033[31m\]'
    green='\[\033[32m\]'
    yellow='\[\033[33m\]'
    blue='\[\033[34m\]'
    white='\[\033[37m\]'

    local venv_name=""
    if [ -n "$VIRTUAL_ENV" ]; then
        venv_name="${red}($(basename "$VIRTUAL_ENV"))${reset} "
    fi

    local dir="${blue}\w${reset}"
    local branch="${yellow}$(__git_ps1)${reset}"

    echo "${venv_name}${dir}${branch}\$ "
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
	bash $AUTO_TMUX/dotfiles.sh
	bash $AUTO_TMUX/notes.sh
	bash $AUTO_TMUX/ngrer.sh

	tmux a -t ngrer
}

daily() {
    # 1. Setup: Define paths and filenames
    # ----------------------------------------------------
    local notes_dir="$HOME/Desktop/black-cape/notes/daily"
    mkdir -p "$notes_dir" # Ensure the directory exists

    local todays_note_file="$notes_dir/$(date +'%Y-%m-%d').md"


    # 2. Early exit: If today's note already exists, just open it.
    # -------------------------------------------------------------------
    if [ -f "$todays_note_file" ]; then
        echo "Opening existing note for today."
        nvim "$todays_note_file"
        return
    fi


    # 3. Find source note: Find the most recent note.
    # -----------------------------------------------------------------------
    local source_note=$(ls -t "$notes_dir"/*.md 2>/dev/null | head -n 1)

    if [ -n "$source_note" ]; then
        echo "Found previous note: $(basename "$source_note"). Checking for tasks..."
    else
        echo "No previous notes found. Creating a fresh daily note."
    fi


    # 4. Extract tasks & create note: Pull unfinished tasks from the source.
    # ----------------------------------------------------------------------
    local carry_over_tasks=""
    if [ -n "$source_note" ]; then
        # This command finds lines between '# TODO' and '# DONE',
        # removes blank lines, and filters out completed tasks '[x]'.
        carry_over_tasks=$(sed -n '/^# TODO/,/^# DONE/p' "$source_note" | sed '1d;$d' | grep -v '\[x\]' | sed '/^$/d')
    fi

    # Create the new note file with the correct content
    if [ -n "$carry_over_tasks" ]; then
        echo "Carrying over unfinished tasks."
        {
            echo "# TODO"
            echo "$carry_over_tasks"
            echo ""
            echo "# DONE"
        } > "$todays_note_file"
    else
        # If no tasks to carry over, create a blank note
        echo -e "# TODO\n\n# DONE" > "$todays_note_file"
    fi


    # 5. Open in neovim: Open the new note and place the cursor.
    # ---------------------------------------------------------------
    # The '+2' command moves the cursor to line 2, right under the # TODO heading.
    nvim +2 "$todays_note_file"
}

dotgit() {
    # Exit immediately if a command exits with a non-zero status.
    set -e

    echo "--- Syncing nvim config ---"
    cd "$DOTFILES/nvim"
    git pull
    git add .
    # The `|| true` prevents the script from exiting if there's nothing to commit
    git commit -m "Updated dotfiles." || true
    git push

    echo "--- Syncing main dotfiles ---"
    cd "$DOTFILES"
    git pull
    git add .
    git commit -m "Updated dotfiles." || true
    git push

    # Unset the -e option if you don't want it affecting other parts of your shell
    set +e
    echo "✅ All dotfiles synced successfully."
}
