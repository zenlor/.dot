#!/bin/sh

# only run strict in office
[ "lg" = "$(hostname)" ] &&\
    exec xidlehook \
    --not-when-fullscreen \
    --timer normal 60 \
    'light -S 1' \
    'light -S 50' \
    --timer primary 15 \
    'light -S 50; lock.sh' \
    '' \
    --timer normal 3600 \
    'systemctl suspend' \
    ''
