#!/bin/sh

#
# Pointer settings
#
xsetroot -cursor_name left_ptr &
if [ "$(hostname)" = "meila" ]; then
	# pesky left-handed gaming mouse
	for i in $(xinput --list | sed -n '/Razer Razer Naga 2014.*pointer/s/.*=\([0-9]\+\).*/\1/p')
	do
		xinput set-prop $i 'Device Accel Profile' -1
		xinput set-prop $i 'Device Accel Constant Deceleration' 2.5
		xinput set-prop $i 'Device Accel Velocity Scaling' 1.0

		xinput set-button-map $i 3 2 1 4 5 6 7 8 9
	done
fi

