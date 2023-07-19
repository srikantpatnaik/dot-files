# README


## Setting up environment


- Install `Termux` either from `F-Droid` or directly 
from [Github](https://github.com/termux/termux-app).

- Install the `dropbear` package for quick `SSH`. Accept all default file
overrides if prompted.

    ```
    pkg update && pkg install dropbear
    ```
- Get the IP address, termux username with `ifconfig` and `whoami` commands. 

- Similarly, set the password by `passwd` command. 

- Now, start `SSH` service by executing `dropbear -R`.

- Connect from your Linux machine with the above set credentials. 


## Installing x11 

- Use the nightly packages to install `termux-x11` android app, which is 
essentially `X11` server.

- `pkg install x11-repo`

- `pkg install termux-x11-nightly`

- `pkg install xfce4`


## Starting X

- `termux-x11 :1 -xstartup "dbus-launch --exit-with-session xfce4-session" -dpi 160`


## Install additional packages (optional)

- `termux-setup-storage`
    
- `pkg install proot-distro`

- `proot-distro install debian`

- `proot-distro login debian --shared-tmp`

#### Run the following inside the debian 

- `ln -sf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime`

- `apt update && apt install -y htop git pulseaudio vim terminator chromium`

- 
