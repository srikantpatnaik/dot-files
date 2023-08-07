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

- `pkg install xfce4 firefox`

- Firefox is stable and doesn't crash during video calls.

- `pkg install tur-repo`

- *chromium* from tur repo is few release old and crashes during google meet.

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

- `pulseaudio --start --load="module-native-protocol-tcp auth-ip-acl=127.0.0.1 auth-anonymous=1" --exit-idle-time=-1 && sleep 3`

- `export XDG_RUNTIME_DIR=${TMPDIR}`

- `termux-x11 :1 -xstartup "dbus-launch --exit-with-session xfce4-session" -dpi 180`

- This setup has already GPU drivers needed for proper functioning

- Copy the theme directories to `.themes` from [here](https://github.com/EliverLara/Sweet/releases/tag/v3.0) 
and [here](http://packages.linuxmint.com/pool/main/m/mint-themes/mint-themes_2.1.5.tar.xz)

## Install additional packages (optional) [not working as of 20 Jul 2023]

- `proot is slow, as it uses system traces, better approach will be using chroot`

- `termux-setup-storage`
    
- `pkg install proot-distro`

- `proot-distro install debian`

- `proot-distro login debian --shared-tmp`
 
- [Reference](https://github.com/termux/termux-packages/issues/14039#issuecomment-1362460223)

#### Run the following inside the debian 

- `ln -sf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime`

- `apt update && apt install -y htop git pulseaudio vim terminator chromium`

## Similar Projects

- [halium](https://halium.org/)

- [droidian xda](https://forum.xda-developers.com/t/rom-linux-lavender-droidian-bookworm.4536313/)

- [droidian](https://droidian.org/)

- [libhybris](https://github.com/libhybris/libhybris)

- [ubports](https://devices.ubuntu-touch.io/installer/)