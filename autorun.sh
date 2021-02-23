#!/bin/bash

function run {
        if ~ pgrep $1 ;
        then
                $@&
        fi
}

# mouse settings
xinput --set-prop 'Logitech G700 Laser Mouse' 'libinput Accel Speed' -0.75
xinput --set-prop 'Logitech G700 Laser Mouse' 'Coordinate Transformation Matrix' 0.5 0 0 0 0.5 0 0 0 0.5

# update copycat repo
# $(cd ~/.config/awesome/awesome-copycats/ && git pull | grep -q -v 'Already up to date.')
#make sure Xresources is current
xrdb -merge ~/.Xresources
#update xdg menu
xdg_menu --format awesome --root-menu /etc/xdg/menus/arch-applications.menu >~/.config/awesome/archmenu.lua
if ! pgrep -f "/usr/bin/picom" >/dev/null 2>&1 ; then
    picom --config ~/.config/picom.conf -b
fi
#start redshift
# check if redshift is already running before launching it
# TODO: is this correct
if ! pgrep -f "/usr/bin/redshift-gtk" >/dev/null 2>&1; then
    redshift-gtk -l 42.36:-71.06 &
fi
