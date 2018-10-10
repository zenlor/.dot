#!/bin/sh
source _lib

# Touchscreen
if [ $HOSTNAME = "red" ]; then
    xinput \
        --map-to-output \
        $(xinput list --id-only "ELAN Touchscreen") \
        eDP-1 &
fi

