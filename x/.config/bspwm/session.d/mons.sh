#!/bin/sh
# mons daemon
if xrandr|grep eDP-1
then
    exec mons -a
fi

exit 0
