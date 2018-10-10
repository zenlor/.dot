#!/bin/sh
# vim: ft=sh

###############
# Environment #
###############

#
# DBus - Start if not running
#
if which dbus-launch >/dev/null && test -z "$DBUS_SESSION_BUS_ADDRESS"; then
    eval "$(dbus-launch --sh-syntax --exit-with-session)"
fi


#############
# AutoStart #
#############

for i in session.d/*.sh; do
    echo "executing $i..."
    /bin/dash $i &
done
