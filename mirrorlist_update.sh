#!/bin/bash

# Commands to:
# Backs up the mirrorlist, then pulls the latest list of https mirrors from the arch linux mirrorlist,
# uncomments all the servers, tests and finds the 10 fastest,
# and then updates the mirrorlist and if successfull cats the file

# see wiki.archlinux.org/index.php/Mirrors#Sorting_mirrors

# backup
cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
# pull and uncomment mirror list, store at /tmp/unsorted_mirrorlist
curl -s "https://archlinux.org/mirrorlist/?country=US&country=CA&protocol=https" | sed -e 's/^#Server/Server/' -e '/^#/d' > /tmp/unsorted_mirrorlist
# Rank top 10 mirrors and store at /tmp/mirrorlist
rankmirrors -n 10 /tmp/unsorted_mirrorlist > /tmp/mirrorlist
# see new mirrorlist
cat /tmp/mirrorlist
# change pacman mirrorlist
cp /tmp/mirrorlist /etc/pacman.d/mirrorlist

# delete tmp files
rm /tmp/unsorted_mirrorlist
rm /tmp/mirrorlist
