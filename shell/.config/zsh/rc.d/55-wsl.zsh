if uname -r|grep -q microsoft;then
    if command -v route >/dev/null; then
        export DISPLAY="$(route -n|grep 0.0.0.0|awk '{print $2;exit;}')":0.0
    else
        export DISPLAY="$(ip route|grep 'default'|awk '{print $3;exit;}')":0.0
    fi
    export KEYMAP=/etc/keymap/us.bmap.gz
    export LIBGL_ALWAYS_INDIRECT=1
fi
