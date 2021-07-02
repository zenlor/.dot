if uname -r|grep -q microsoft;then
    if [[ ! -v WAYLAND_DISPLAY ]]; then
        if command -v route >/dev/null; then
            WSL_IP="$(route -n|grep 0.0.0.0|awk '{print $2;exit;}')"
        else
            WSL_IP="$(ip route|grep 'default'|awk '{print $3;exit;}')"
        fi
        export DISPLAY="${WSL_IP}:0.0"
        export KEYMAP=/etc/keymap/us.bmap.gz
        export LIBGL_ALWAYS_INDIRECT=1

        export PULSE_SERVER="tcp:${WSL_IP}"
    fi
fi
