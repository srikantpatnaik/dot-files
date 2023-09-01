# Steps to run postmarketOS on Xiaomi Pad 5 (nabu)

**The steps below are taken from [xda member serdeliuk](https://forum.xda-developers.com/t/rom-postmarketos-linux-boot-on-xiaomi-pad-5-nabu.4454143/)**

## Install ADB on your host machine (I'm using GNU/Linux)

1. Wait for 15 days to unlock your tablet (unlock will remove all user data!)

2. `wget https://github.com/serdeliuk/xiaomi-nabu-orangefox/releases/download/2/xiaomi-nabu-orangefox.0.0.2.zip`

3. `unzip xiaomi-nabu-orangefox.0.0.2.zip`

4. Optionally download original Firmware from [here](https://xiaomifirmwareupdater.com/miui/nabu/)

5. `adb reboot bootloader`

6. `fastboot boot xiaomi-nabu-orangefox.img`

7. Run the following commands in `adb shell`

8. We are interested in userdata `ls -l /dev/block/bootdevice/by-name/ | grep userdata`

9. `parted /dev/block/sda`

10. Inside parted `print` and then remove userdata partition `rm 31`

11. Inside parted the 30th partition ends at 10.9GB and for 256GB version of tablet one can use 
`mkpart userdata   10.9GB 100GB`. This shall create ~90GB userdata partition and rest will be kept for `pmos`.

12. Inside parted now create `pmos` partition `mkpart pmos ext4 100GB 250GB`

13. Inside parted check the free space `print free` if it shows a few GBs then you might go back and adjust your
    partitions, if not, do `quit` and reboot.

14. The reboot should land you to recovery screen, select WIPE USERDATA and reboot to Android with new userdata 

15. Connect `adb` and do `adb reboot bootloader` again

16. Now when `FASTBOOT` appears on screen run `fastboot getvar current-slot`. This usually should print `a`, this means
    the Android uses `slot a`, this also means that `slot b` could be used for `pmos`!

17. There are 3 partitions involved to boot pmos? boot, vbmeta, dtbo? (need more info)

18. `fastboot set_active b`

19. Download the pmos preview image from [here](https://github.com/serdeliuk/xiaomi-nabu-postmarketos/releases/download/6.1.10/xiaomi-nabu-pmos-preview.6.1.10.tar.gz)

20. Extract the above tar file and `cd` into it

21. Flash the modified vbmeta to disable verify boot `fastboot flash vbmeta_b vbmeta_disabled.img`

22. Erase to prevent loading and interfering with with pmos `fastboot erase dtbo_b` ?

23. Flash Linux Kernel to `slot b` boot region `fastboot flash boot_b boot.img`
    (You may use alternate kernel from [here](https://forum.xda-developers.com/attachments/boot-img.5834319/) which contains 
    `CONFIG_SCSI_UFS_BSG` for switching slots using `qbootctl`)

24. Now flash prebuilt Alpine image (pmos) `fastboot flash pmos xiaomi-nabu.img` 

25. Once done `fastboot reboot` to get into `KDE Desktop`.

26. Default user is `user` and password is `147147` [details](https://forum.xda-developers.com/t/rom-postmarketos-linux-boot-on-xiaomi-pad-5-nabu.4454143/)

## Tuning the Plasma Desktop 

1. Wait for the touch to work then perhaps use two fingers to swiftly click the session selector 
   and change it to `Plasma X11`. The default `Wayland` session tend to crash the plasma-shell and it
   also has touch issues (my feeling?).

2. Connect a bluetooth keyboard and mouse as soon as you login first time, now connect to Wifi, change the date to fetch from NTP

3. Change the system font size to 12 or so, increase the display scaling to 125%, and change the theme to Dark (as you may like)

4. Create profile in Konsole and change the font, size, background etc 

5. Change the sleep time to 1 min in power settings to save as much power as possible





## Root any device (You must unlock the device first)

1. Get the original factory firmware(android OS) for your region, in our case download 
   the fastboot version from [here](https://xiaomifirmwareupdater.com/miui/nabu/)

2. Extract the firmware and navigate to `images` directory. 

3. `adb push boot.img /sdcard`

4. Install `Magisk` from [here](https://github.com/topjohnwu/Magisk/releases)

5. In the Magisk app click on the first install then do `select and patch a file` and patch

6. Do `adb pull /storage/emulated/0/Download/magisk_patched-xxxx_xxxx.img`

7. Restart device `adb reboot bootloader`

8. `fastboot flash boot magisk_patched-xxxx_xxxx.img`

9. `fastboot reboot` and done.
   
## Switch Slots

### Android(slot A) to Linux(slot B)

Install the APK from [here](https://github.com/gibcheesepuffs/Switch-My-Slot-Android/releases/tag/v0.7.1) and install the Magisk 
module from [here](https://github.com/roihershberg/bootctl-binary/releases/tag/v2.2). Use the app to switch the slot.

### Linux(slot B) to Android(slot A)

1. `sudo apk add qbootctl`

2. `sudo qbootctl -s a && sudo reboot`

## References

* [Partitioning](https://forum.xda-developers.com/t/resize-internal-storage-on-xiaomi-pad-5-nabu-and-install-postmarketos-preview.4543835/)

* [Build Kernel](https://forum.xda-developers.com/t/rom-postmarketos-linux-boot-on-xiaomi-pad-5-nabu.4454143/post-88534869)

* [Boot to Linux](https://github.com/gibcheesepuffs/Switch-My-Slot-Android)

* [Android verified boot](https://wiki.postmarketos.org/wiki/Android_Verified_Boot_(AVB))

* [Boot to Android](https://forum.xda-developers.com/t/rom-postmarketos-linux-boot-on-xiaomi-pad-5-nabu.4454143/post-88776459)

* [Adreno 640 GPU driver: Freedreno](https://gitlab.freedesktop.org/freedreno/freedreno/-/wikis/home)

* [Adreno 640 GPU driver: Freedreno Alpine aarch64](https://pkgs.alpinelinux.org/package/edge/main/aarch64/mesa-vulkan-freedreno)
