#!/bin/sh

# Restore the bindings
tmux bind -n C-h select-pane -L
tmux bind -n C-j select-pane -D
tmux bind -n C-k select-pane -U
tmux bind -n C-l select-pane -R
