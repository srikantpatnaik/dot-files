# Steps to run postmarketOS on Xiaomi Pad 5 (nabu)

**The steps below are taken from [xda member serdeliuk](https://forum.xda-developers.com/t/rom-postmarketos-linux-boot-on-xiaomi-pad-5-nabu.4454143/)

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

24. Now flash prebuilt Alpine image (pmos) `fastboot flash pmos xiaomi-nabu.img`

25. Default user is `user` and password is `147147` [details](https://forum.xda-developers.com/t/rom-postmarketos-linux-boot-on-xiaomi-pad-5-nabu.4454143/)

## An alpine on mipad5

1. Tune with `powertop`

2. Make USB receive more current on Linux

3. CPU powersave and DPMS when sleep

4. Use GNOME with extension to make on screen keyboard automatically appear


## References

* [Partitioning](https://forum.xda-developers.com/t/resize-internal-storage-on-xiaomi-pad-5-nabu-and-install-postmarketos-preview.4543835/)

* [Build Kernel](https://forum.xda-developers.com/t/rom-postmarketos-linux-boot-on-xiaomi-pad-5-nabu.4454143/post-88534869)

* [Boot to Linux](https://github.com/gibcheesepuffs/Switch-My-Slot-Android)

* [Boot to Android](https://forum.xda-developers.com/t/rom-postmarketos-linux-boot-on-xiaomi-pad-5-nabu.4454143/post-88776459)

* [Adreno 640 GPU driver: Freedreno](https://gitlab.freedesktop.org/freedreno/freedreno/-/wikis/home)

* [Adreno 640 GPU driver: Freedreno Alpine aarch64](https://pkgs.alpinelinux.org/package/edge/main/aarch64/mesa-vulkan-freedreno)
