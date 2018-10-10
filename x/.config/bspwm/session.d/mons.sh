#!/bin/sh
source _lib

# mons daemon
[ $HOSTNAME = "red" ] && _lock mons -a
