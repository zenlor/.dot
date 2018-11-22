#!/bin/sh
# mons daemon
[ $HOSTNAME = "red" ] && exec mons -a || exit 0
