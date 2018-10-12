#!/bin/sh
source `dirname $0`/_lib

# mons daemon
[ $HOSTNAME = "red" ] && _lock mons -a
