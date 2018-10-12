#!/bin/sh
source `dirname $0`/_lib

# Lock screen for red
if [ "$HOSTNAME" = "red" ]; then
    _lock $HOME/.cargo/bin/xidlehook \
        --time 5 \
        --timer 'light -S 50; slock' \
        --notify 10 \
        --notifier  'light -S 1' \
        --canceller 'light -S 50' \
        --not-when-fullscreen \
        --not-when-audio
fi

