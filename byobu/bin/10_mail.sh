#!/bin/sh

COLOR_SET="#[fg=white bg=blue bold]"
COLOR_RESTORE="#[fg=$BYOBU_LIGHT bg=$BYOBU_DARK]"

# Notification 1: Mutt inbox count
gmailinbox="$HOME/stuff/Mail/Gmail//INBOX/new/"
echo "$COLOR_SET""$(find $gmailinbox -type f | wc -l)""$COLOR_RESTORE"

