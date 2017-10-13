#!/usr/bin/env bash

function run {
        if ~ pgrep $1 ;
        then
                $@&
        fi
}
#make sure Xresources is current
xrdb -merge ~/.Xresources
#start redshift
#python2 /usr/bin/redshift-gtk
redshift
#update xdg menu
xdg_menu --format awesome --root-menu /etc/xdg/menus/arch-applications.menu >~/.config/awesome/archmenu.lua
#start compton (isn't happening?)
compton --config ~/.config/compton.conf -b 
