CHROOTPATH="$PWD/kali-arm64"
su -c mkdir -p $CHROOTPATH/sdcard
su -c mkdir -p /dev/shm
#user="root"
user="sri"

umountchroot() {
	su -c umount -l $CHROOTPATH/dev/shm
	su -c umount -l $CHROOTPATH/dev/pts
	su -c umount -l $CHROOTPATH/dev
	su -c umount -l $CHROOTPATH/proc
	su -c umount -l $CHROOTPATH/sys
	su -c umount -l $CHROOTPATH/sdcard
	mount | grep kali
}
cleanall() {
	killall pulseaudio 
	rm -rf ~/.config/pulse/*
	kill -9 $(pgrep -f termux.x11) 
	kill -9 $(pgrep -f virgl_test)
	umountchroot
}

hostscript() {
	virgl_test_server_android &
	pulseaudio --start --load="module-native-protocol-tcp auth-ip-acl=127.0.0.1 auth-anonymous=1" --exit-idle-time=-1
	pacmd load-module module-native-protocol-tcp auth-ip-acl=127.0.0.1 auth-anonymous=1
	TMPDIR=$PWD/kali-arm64/tmp XDG_RUNTIME_DIR=${TMPDIR} termux-x11 :2 -ac &
}

mountchroot() {
	su -c  mount -o remount,dev,suid /data
	su -c  mount --bind /dev $CHROOTPATH/dev
	su -c  mount --bind /sys $CHROOTPATH/sys
	su -c  mount --bind /proc $CHROOTPATH/proc
	su -c  mount --bind /dev/shm $CHROOTPATH/dev/shm
	su -c  mount -t devpts devpts $CHROOTPATH/dev/pts
	su -c  mount --bind /sdcard $CHROOTPATH/sdcard
}
startchroot() {
	echo "sudo chmod 777 /dev/shm" > startxfce.sh
	echo "export PULSE_SERVER=127.0.0.1 && pulseaudio --start --disable-shm=1 --exit-idle-time=-1" >> startxfce.sh
	#echo "DISPLAY=:2 GALLIUM_DRIVER=virpipe MESA_GL_VERSION_OVERRIDE=4.0 dbus-launch --exit-with-session startxfce4" >> startxfce.sh
	echo "GALLIUM_DRIVER=virpipe MESA_GL_VERSION_OVERRIDE=4.0" >> startxfce.sh
	echo "DISPLAY=:2 MESA_LOADER_DRIVER_OVERRIDE='' dbus-launch --exit-with-session startxfce4" >> startxfce.sh
	su -c "mv -v startxfce.sh $CHROOTPATH/home/$user/"
	su -c "cat $CHROOTPATH/home/$user/startxfce.sh"
	su -c "chmod 777 $CHROOTPATH/home/$user/startxfce.sh"
	su -c chroot $CHROOTPATH /bin/su - $user "/home/$user/startxfce.sh"
}

main() {
	cleanall
	hostscript
	mountchroot
	startchroot
	umountchroot
	cleanall
}

main &> .chrootkali.log
