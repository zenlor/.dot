#!/bin/sh
source _lib

#
# Polybar
#
# select primary monitor
case $HOSTNAME in
    red)
        export PRIMARY_MONITOR=eDP-1
        ;;
    *)
        export PRIMARY_MONITOR="$(xrandr | grep primary | cut -d' ' -f1)"
    ;;
esac
_lock polybar -r bar

