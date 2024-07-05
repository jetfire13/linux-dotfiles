#!/bin/sh

# feh --bg-scale ~/some/image.png
# setxkbmap us,ru -option 'grp:caps_toggle'
export STATUSBAR=dwmblocks
export EDITOR=nvim
export QT_QPA_PLATFORMTHEME=qt6ct

dwmblocks &
picom &

while true; do
	# Log stderror to a file
	dwm 2> ~/.dwm.log
	# No error logging
	# dwm >/dev/null 2>&1
done
