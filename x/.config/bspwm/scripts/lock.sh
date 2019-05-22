#!/bin/sh

if command -v cowfortune >/dev/null 2>&1; then
    exec slock -m "`cowfortune`"
else
    exec slock -m "${USER}@${HOSTNAME}"
fi
