#!/bin/sh
source _lib

_lock compton --dbus --config $HOME/.config/compton/compton.conf -b
