init() {
  killall pulseaudio
  kill -9 $(pgrep virgl_test)
  rm ~/.config/pulse/*
  virgl_test_server_android &
  # next 2 lines for PA is optional
  #pulseaudio --start --load="module-native-protocol-tcp auth-ip-acl=127.0.0.1 auth-anonymous=1" --exit-idle-time=-1
  #pacmd load-module module-native-protocol-tcp auth-ip-acl=127.0.0.1 auth anonymous=1
  export XDG_RUNTIME_DIR=${TMPDIR}
  GALLIUM_DRIVER=virpipe MESA_GL_VERSION_OVERRIDE=4.0 termux-x11 :1 -xstartup "dbus-launch --exit-with-session xfce4-session" -dpi 180 
}

init &> .default-x11.log  
