#!/bin/sh
source _lib
_lock wallpaper

if [ $HOSTNAME = "red" ];then
    exit 0
fi

#
# Wallpaper set
#
[ -x "$HOME/.config/wallpapers/set" ] && $HOME/.config/wallpapers/set
