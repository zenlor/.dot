#!/bin/sh
#
# Laptop Power management
#
[ $HOSTNAME = "red" ] && exec xfce4-power-manager --no-daemon || exit 0
