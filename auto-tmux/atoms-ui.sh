#!/bin/bash

SESH="ATOMS-ui"
UI_DIR="$WORK_REPOS/ATOMS/chronicle-ui"
API_DIR="$WORK_REPOS/ATOMS/oms-bridge"

tmux has-session -t $SESH 2>/dev/null

if [ $? != 0 ]; then
	tmux new-session -d -s $SESH -n "editor" -c $UI_DIR

	tmux send-keys -t $SESH:editor "cd $UI_DIR" C-m
	tmux send-keys -t $SESH:editor "nvim ." C-m

	tmux new-window -t $SESH -n "terminal"
	tmux send-keys -t $SESH:terminal "cd $UI_DIR" C-m
	tmux send-keys -t $SESH:terminal "git status" C-m

	tmux new-window -t $SESH -n "server" -c "$UI_DIR"
	tmux split-window -v -t $SESH:server.1 -c "$API_DIR"
	tmux send-keys -t $SESH:server.2 "cd $API_DIR && docker desktop start && make dockerrefresh &" C-m
	tmux send-keys -t $SESH:server.1 "npm ci && npm run start" C-m

	tmux select-window -t $SESH:terminal
fi
