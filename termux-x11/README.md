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

- `pkg install tur-repo`

- `pkg install chromium`

## Increase the process limit in Android to avoid termux-x11 being killed

- Connect your phone with `Android adb` and execute the following

    ```
    adb shell "/system/bin/device_config set_sync_disabled_for_tests persistent; /system/bin/device_config put activity_manager max_phantom_processes 2147483647"

- To verify at any point, run 

    ```
    adb shell "/system/bin/device_config list activity_manager"

    ```

## Starting X

- `termux-x11 :1 -xstartup "dbus-launch --exit-with-session xfce4-session" -dpi 160`

- `This setup has already GPU drivers needed for proper functioning

## Install additional packages (optional) [not working as of 20 Jul 2023]

- `termux-setup-storage`
    
- `pkg install proot-distro`

- `proot-distro install debian`

- `proot-distro login debian --shared-tmp`

#### Run the following inside the debian 

- `ln -sf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime`

- `apt update && apt install -y htop git pulseaudio vim terminator chromium`

