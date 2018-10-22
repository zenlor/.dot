#!/bin/sh
# vim: ft=sh

# pid list
pids=""

store_pid() {
    pids="$pids $1"
}

onexit() {
    echo "SIGINT received"
    echo "sending SIGTERM to all processes"
    kill $pids
    sleep 1
}

log() {
  local index="$2"
  local format="%s\t| %s"

  while read -r data
  do
    printf "$format\n" "$1" "$data"
  done
}

start_command() {
    sh -c "$1" 2>&1 | log $1 &
    store_pid "$(jobs -p %%)"
}

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

cd -P -- "$(dirname -- "$0")"/session.d
for i in $HOME/.config/bspwm/session.d/*.sh; do
    echo "executing $i..."
    start_command $i
    echo "started command $i"
done

trap onexit INT TERM

wait $pids
