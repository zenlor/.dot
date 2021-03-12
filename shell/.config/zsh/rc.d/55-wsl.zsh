# Microsoft bugs: WSL1
if uname -r|grep -q Microsoft;then
    export DISPLAY=:0
    export LIBGL_ALWAYS_INDIRECT=1

    # See https://github.com/Microsoft/BashOnWindows/issues/1887
    unsetopt BG_NICE
    # Microsoft bugs: WSL2
elif uname -r|grep -q microsoft;then
    #export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2; exit;}'):0.0
    export DISPLAY="$(route -n | grep 0.0.0.0 | awk '{print $2;exit;}')":0.0
fi
