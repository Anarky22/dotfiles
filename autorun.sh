#!/bin/bash

function run {
        if ~ pgrep $1 ;
        then
                $@&
        fi
}
#make sure Xresources is current
xrdb -merge ~/.Xresources
#update xdg menu
xdg_menu --format awesome --root-menu /etc/xdg/menus/arch-applications.menu >~/.config/awesome/archmenu.lua
compton --config ~/.config/compton.conf -b
#start redshift
# check if redshift is already running before launching it
if ! pgrep -f "/usr/bin/redshift-gtk" >/dev/null 2>&1 ; then
    redshift-gtk &
fi
