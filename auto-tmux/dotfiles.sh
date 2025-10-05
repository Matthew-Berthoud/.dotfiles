#!/bin/bash

# Define session name and the root directory
SESSION_NAME="dotfiles"
SESSION_ROOT="$HOME/.dotfiles"

# Check if the session already exists. If it does, do nothing.
# The '2>/dev/null' part suppresses the "can't find session" error message.
if ! tmux has-session -t "$SESSION_NAME" 2>/dev/null; then

    # -d: detached mode
    # -s: session name
    # -n: window name
    # -c: starting directory

    tmux new-session -d -s "$SESSION_NAME" -n editor -c "$SESSION_ROOT" "nvim README.md"
    tmux new-window -t "$SESSION_NAME" -n terminal -c "$SESSION_ROOT" \
        "bash -c 'source ~/.bashrc && dotgit && dotrun && tree'"

    tmux select-window -t "$SESSION_NAME:terminal"

    echo "Tmux session '$SESSION_NAME' created."
else
    echo "Tmux session '$SESSION_NAME' already exists."
fi
