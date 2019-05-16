#!/bin/sh

exec xidlehook \
  --not-when-fullscreen \
  --timer normal 60 \
    'light -S 1' \
    'light -S 50' \
  --timer primary 15 \
    'light -S 50; slock' \
    '' \
  --timer normal 3600 \
    'systemctl suspend' \
    ''
