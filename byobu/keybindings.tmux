unbind -n C-a
#unbind -n F1
#unbind -n F2
bind-key -n S-Left previous-window
bind-key -n S-Right next-window
bind-key -n M-Up display-panes \; select-pane -U 
bind-key -n M-Down display-panes \; select-pane -D 
bind-key -n M-Left display-panes \; select-pane -L 
bind-key -n M-Right display-panes \; select-pane -R
#bind-key -n F1 display-panes \; select-pane -t :.-
#bind-key -n F2 display-panes \; select-pane -t :.+
#unbind-key -n C-a
set -g prefix ^A
set -g prefix2 F12
bind a send-prefix
