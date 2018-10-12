#!/bin/sh
source `dirname $0`/_lib

if [ $HOSTNAME = "red" ];then
    exit 0
fi

#
# Wallpaper set
#
[ -x "$HOME/.config/wallpapers/set" ] && $HOME/.config/wallpapers/set
