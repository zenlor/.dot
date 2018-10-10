#!/bin/sh
source _lib

#
# Laptop Power management
#
[ $HOSTNAME = "red" ] && _lock xfce4-power-management
