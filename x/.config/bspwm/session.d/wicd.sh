#!/bin/sh
command -v wicd-client >/dev/null 2>&1 \
    && exec wicd-client --tray
