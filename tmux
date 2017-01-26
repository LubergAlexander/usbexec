#!/bin/bash
SESSNAME=usbexec

tmux kill-session -t $SESSNAME
 
tmux new -d -s $SESSNAME "watch -c -d -n1 'ps -A | grep -i usbexec'"
tmux split-window "bash -c 'echo YOUR CONSOLE; echo; bash -l'"
tmux select-pane -U
tmux split-window -h "bash -c 'tail -F $HOME/.usbexec/usbexec*.log; bash -l'"
tmux select-pane -D
tmux split-window -h "bash -c 'echo SYSTEMLOGS; echo; sudo tail -F /var/log/system.log; bash -l'"
tmux select-pane -L

tmux attach
