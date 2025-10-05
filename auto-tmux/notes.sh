#!/bin/bash

SESH="notes"
DIR="$HOME/Desktop/black-cape/notes"

tmux has-session -t $SESH 2>/dev/null

if [ $? != 0 ]; then
	tmux new-session -d -s $SESH -n "editor" -c $DIR

	tmux send-keys -t $SESH:editor "cd $DIR" C-m
	tmux send-keys -t $SESH:editor "daily" C-m

	tmux select-window -t $SESH:editor
fi
