#!/bin/sh

[ ! "$HOSTNAME" = "red" ] && exit 0

exec wicd-client --tray
