if uname -r|grep -q microsoft;then
    export DISPLAY="$(route -n | grep 0.0.0.0 | awk '{print $2;exit;}')":0.0
    export KEYMAP=/etc/keymap/us.bmap.gz
    export LIBGL_ALWAYS_INDIRECT=1
fi
