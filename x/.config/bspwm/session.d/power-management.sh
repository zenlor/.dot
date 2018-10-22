#!/bin/sh
source `dirname $0`/_lib

#
# Laptop Power management
#
[ $HOSTNAME = "red" ] && _lock xfce4-power-manager --no-daemon
