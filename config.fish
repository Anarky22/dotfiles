# Set umask
umask 022

set -U fish_user_paths /usr/local/sbin /usr/local/bin /usr/bin /home/neil/.local/bin/ /home/neil/mpich-install/bin/

# disable start message
set -U fish_greeting

set -x EDITOR /usr/bin/nvim

alias icat="kitty +kitten icat"
# set remote terminal TERM on ssh
alias ssh="kitty +kitten ssh"
# alias ssh="TERM=\'xterm-256color\' command ssh"

# Use exa instead of ls
alias ls="exa"
alias ll="exa -l"

# create rmi
alias rmi="rm -i"

# cl
alias cl="cd $argv; and exa"

# Termcap is outdated, old, and crusty, kill it.
set -x TERMCAP
