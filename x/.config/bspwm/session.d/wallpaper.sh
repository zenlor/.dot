#!/bin/sh
source `dirname $0`/_lib

if [ $HOSTNAME = "red" ];then
    exit 0
fi

#
# Wallpaper set
#
exec feh --bg-tile $HOME/.config/wallpapers/pattern.jpg
