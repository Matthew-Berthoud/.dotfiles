#!/bin/bash

SESH="ATOMS-ui"
DIR="$WORK_REPOS/ATOMS/chronicle-ui"

tmux has-session -t $SESH 2>/dev/null

if [ $? != 0 ]; then
	tmux new-session -d -s $SESH -n "editor" -c $DIR

	tmux send-keys -t $SESH:editor "cd $DIR" C-m
	tmux send-keys -t $SESH:editor "nvim ." C-m

	tmux new-window -t $SESH -n "terminal"
	tmux send-keys -t $SESH:terminal "cd $DIR" C-m
	tmux send-keys -t $SESH:terminal "git status" C-m

	tmux new-window -t $SESH -n "server"
	tmux send-keys -t $SESH:server "cd $DIR" C-m
	tmux send-keys -t $SESH:server "npm install" C-m
	tmux send-keys -t $SESH:server "npm run start" C-m

	tmux new-window -t $SESH -n "unit-tests"
	tmux send-keys -t $SESH:unit-tests "cd $DIR" C-m
	
	tmux new-window -t $SESH -n "cypress"
	tmux send-keys -t $SESH:cypress "cd $DIR" C-m

	tmux select-window -t $SESH:terminal
fi
