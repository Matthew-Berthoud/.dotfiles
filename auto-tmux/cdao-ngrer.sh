#!/bin/bash

SESH="CDAO-NGRER"
DIR="$WORK_REPOS/CDAO/ngrer"

tmux has-session -t $SESH 2>/dev/null

if [ $? != 0 ]; then
	tmux new-session -d -s $SESH -n "editor" -c $DIR

	tmux send-keys -t $SESH:editor "cd $DIR && source .venv/bin/activate && uv sync " C-m
	tmux send-keys -t $SESH:editor "nvim ." C-m

	tmux new-window -t $SESH -n "terminal"
	tmux send-keys -t $SESH:terminal "cd $DIR && source .venv/bin/activate && uv sync " C-m
	tmux send-keys -t $SESH:terminal "git status" C-m

	tmux new-window -t $SESH -n "jupyter"
	tmux send-keys -t $SESH:jupyter "cd $DIR && source .venv/bin/activate && uv sync " C-m
	# tmux send-keys -t $SESH:jupyter "jupyter notebook" C-m

	tmux select-window -t $SESH:terminal
fi
