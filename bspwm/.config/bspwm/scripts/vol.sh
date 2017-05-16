#!/bin/dash
case "$1" in
    "up")
        pulseaudio-ctl up
        ;;
    "down")
        pulseaudio-ctl down
        ;;
    "mute")
        pulseaudio-ctl mute
        ;;
    *)
        exit 1
        ;;
esac

volume="$(pulseaudio-ctl full-status|sed 's|[^0-9]||g')"
notify-send -u low -t 1500 "volume ${volume}%"
