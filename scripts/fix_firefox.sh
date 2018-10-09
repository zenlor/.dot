#!/bin/sh

BASEDIR=$HOME/.mozilla/firefox
PROFILE=`grep 'Path=' .mozilla/firefox/profiles.ini | head -n1 | sed 's/Path=//'`

# make chrome directory
mkdir -p $BASEDIR/$PROFILE/chrome
FILENAME=$BASEDIR/$PROFILE/chrome/userChrome.css

echo '#contentAreaContextMenu { margin: 10px 0px 0px 10px; }' >>$FILENAME