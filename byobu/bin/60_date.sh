#!/bin/sh

COLOR_SET="#[fg=white bg=brown bold]"
COLOR_RESTORE="#[fg=$BYOBU_LIGHT bg=$BYOBU_DARK]"

# Notification 2: Formatted date
echo "$COLOR_SET""$(date +%d-%m-%Y\ %a\ \%H:%M)""$COLOR_RESTORE"

