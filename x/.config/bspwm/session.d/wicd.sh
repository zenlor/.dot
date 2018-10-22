#!/bin/sh
source `dirname $0`/_lib

[ ! "$HOSTNAME" = "red" ] && exit 0

_lock wicd-client --tray
