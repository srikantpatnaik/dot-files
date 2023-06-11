# diff
# ################
## Awesome WM ##
################

# wait 2s for screenshot
alias ss="flameshot gui -d 2000"
# screen lock
alias sl="i3lock -c 000000" #screen lock or use slock
# suspend
alias sp="slock sudo pm-suspend"
# stats
alias stat="tmon -s echo 2>&1| grep --color=never avg; echo -n 'bat: ';cat /sys/class/power_supply/BAT0/capacity | tr -d '\n'"
# ~/.local/bin/bl to adjust backlight
  # #!/bin/bash
  #if [ "$1" -lt 100 ]; then
  #factor=$(( "$1" * 960 ))
  #sudo bash -c "echo ${factor} > /sys/class/backlight/intel_backlight/brightness"
  #fi  
# nm-applet run when needed (or)
  # nmcli dev wifi list
  # nmcli dev wifi connect <ssid>
# xinput set-prop "DELL0A68:00 06CB:CE65 Touchpad" "libinput Tapping Enabled" 1
# pavucontrol
# howdoi (ask coding questions to ai)
# socli (stackoverflow cli)
