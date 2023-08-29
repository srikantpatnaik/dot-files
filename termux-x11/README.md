# README

## Setting up environment

- Install `Termux` either from `F-Droid` or directly 
from [Github](https://github.com/termux/termux-app).

- Install the `openssh` package for quick `SSH`. Accept all default file
overrides if prompted.

    ```
    pkg update && pkg install openssh
    ```
- Get the IP address, termux username with `ifconfig` and `whoami` commands. 

- Similarly, set the password by `passwd` command. 

- Now, start `SSH` service by executing `sshd`.

- Connect from your Linux machine with the above set credentials. 


## Installing x11 

- Use the nightly packages to install `termux-x11` [android app](https://github.com/termux/termux-x11/releases/), which is 
essentially `X11` server.

- `pkg install x11-repo`

- `pkg install termux-x11-nightly`

- `pkg install xfce4 firefox pulseaudio virglrenderer-android`

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

- Disable `Windows/Command` key

    ```
    adb shell "settings put system is_custom_shortcut_effective 0"
    ```
- [Reference](https://github.com/CwithW/MiuiPadMeta)

- Remove the bottom gesture bar

    ```
    adb shell "settings put global hide_gesture_line 1"
    ```

- The settings command can also be done by `setedit` android app from playstore

## Starting X

- This setup has already GPU driver `virglrenderer-android` needed for proper functioning (test using webgl aquarium)

- For mic to work, add the following lines at the end of `../usr/etc/pulse/default.pa` file and comment the line for pulseaudio
  in `default-11.sh`.

  ```
  load-module module-sles-source
  load-module module-null-sink sink_name=virtspk sink_properties=device.description=Virtual_Speaker
  ```

- `./default-x11.sh`

- When using direct touch option in termux-x11 preferences one can enable the same for Firefox by

    ```
    env MOZ_USE_XINPUT2=1 firefox
    ```

- Copy the theme directories to `.themes` from [here](https://github.com/EliverLara/Sweet/releases/tag/v3.0) 
and [here](http://packages.linuxmint.com/pool/main/m/mint-themes/mint-themes_2.1.5.tar.xz)


## proot (optional)

- `proot is slow, as it uses system traces, better approach will be using chroot`

- `termux-setup-storage`
    
- `pkg install proot-distro`

- `proot-distro install debian`

- `proot-distro login debian --shared-tmp`
 
- [Reference](https://github.com/termux/termux-packages/issues/14039#issuecomment-1362460223)

#### Run the following inside the debian 

- `ln -sf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime`

- `apt update && apt install -y htop git pulseaudio vim terminator chromium`

- Follow the next steps similar to `default-x11.sh`

- [Reference](https://ivonblog.com/en-us/posts/termux-virglrenderer/)


## chroot (optional) 

- Assuming you have `root` access, then obtain the `ssh` session or `adb` session to jumpstart

- `pkg install tsu`

- `wget https://kali.download/nethunter-images/current/rootfs/kalifs-arm64-minimal.tar.xz`

- `sudo tar xpf kalifs-arm64-minimal.tar.xz --numeric-owner`

- Copy the `chrootkali.sh` to the same directory as of `kali-arm64`

- `su -s ./chrootkali.sh`

- Inside the chroot run the following

    ```
    echo "nameserver 8.8.8.8" > /etc/resolv.conf
    echo "127.0.0.1 localhost" > /etc/hosts
    groupadd -g 3003 aid_inet
    groupadd -g 3004 aid_net_raw
    groupadd -g 1003 aid_graphics
    usermod -g 3003 -G 3003,3004 -a _apt
    usermod -G 3003 -a root
    ln -sf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime
    groupadd storage
    groupadd wheel
    useradd -m -g users -G wheel,audio,video,storage,inet,net_raw,sockets -s /bin/bash sri
    passwd sri
    ```
- Inside chroot add user to sudo group `user    ALL=(ALL:ALL) NOPASSWD:ALL` using `sudo visudo`

- Exit chroot and change the `chrootkali.sh` to login using new user

- `apt install -y vim net-tools sudo git xfce4 xfce4-goodies dbus-x11 chromium vlc `

- Change `allowed_users = anybody` in `/etc/X11/Xwrapper.config`

- Remove power manager or else X will fail `apt purge xfce4-power-manager`

### Starting Kali chroot

- `./chrootkali.sh`

### Stopping Kali chroot

- `cntl + c` or `logout in Xfce`


## Similar Projects

- [halium](https://halium.org/)

- [droidian xda](https://forum.xda-developers.com/t/rom-linux-lavender-droidian-bookworm.4536313/)

- [droidian](https://droidian.org/)

- [libhybris](https://github.com/libhybris/libhybris)

- [ubports](https://devices.ubuntu-touch.io/installer/)
