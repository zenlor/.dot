#!/bin/sh
source `dirname $0`/_lib

_lock compton --dbus --config $HOME/.config/compton/compton.conf -b
