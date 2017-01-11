#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

[ -f /etc/xprofile ] && source /etc/xprofile
[ -f ~/.xprofile ] && $HOME/.xprofile

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

xset r rate 200 20

setxkbmap en
setxkbmap -option ctrl:nocaps
# xmodmap -e 'clear lock'
# xmodmap -e 'keycode 66 = Hyper_L'


dunst -conf $HOME/.config/dunst/dunstrc &
compton --dbus --config $HOME/.config/compton/compton.conf -b

exec bspwm $HOME/.config/bspwm/bspwm
