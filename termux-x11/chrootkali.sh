#!/bin/sh

CHROOTPATH="$PWD/kali-arm64"
mkdir -p $CHROOTPATH/sdcard
#user="root"
user="sri"

# Fix setuid issue
busybox mount -o remount,dev,suid /data
busybox mount --bind /dev $CHROOTPATH/dev
busybox mount --bind /sys $CHROOTPATH/sys
busybox mount --bind /proc $CHROOTPATH/proc
busybox mount -t devpts devpts $CHROOTPATH/dev/pts

# Mount sdcard
busybox mount --bind /sdcard $CHROOTPATH/sdcard

# chroot 
busybox chroot $CHROOTPATH /bin/su - root

# Umount everything after exit
busybox umount $CHROOTPATH/dev/pts
busybox umount $CHROOTPATH/dev
busybox umount $CHROOTPATH/proc
busybox umount $CHROOTPATH/sys
