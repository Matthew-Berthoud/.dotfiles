#!/bin/bash

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
    bash $AUTO_TMUX/atoms-ui.sh
    bash $AUTO_TMUX/cdao-ngrer.sh

    tmux a -t ATOMS-ui
}

daily() {
    # 1. Setup: Define paths and filenames
    local notes_dir="$HOME/Desktop/black-cape/notes/daily"
    mkdir -p "$notes_dir" # Ensure the directory exists

    local todays_note_file="$notes_dir/$(date +'%Y-%m-%d').md"

    # 2. Early exit: If today's note already exists, just open it.
    if [ -f "$todays_note_file" ]; then
        echo "Opening existing note for today."
        nvim "$todays_note_file"
        return
    fi

    # 3. Find source note, carry over tasks
    local source_note=$(ls -t "$notes_dir"/*.md 2>/dev/null | head -n 1)

    if [ -n "$source_note" ]; then
        echo "Found previous note: $(basename "$source_note"). Carrying over tasks..."
        # If a source note exists, copy everything from the start of the
        # file up to and including the '# DONE' line to the new note.
        sed '/^# DONE/q' "$source_note" > "$todays_note_file"
    else
        echo "No previous notes found. Creating a fresh daily note."
        echo -e "# TODO\n\n# DONE" > "$todays_note_file"
    fi

    nvim "$todays_note_file"
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
