# Set umask
umask 022

set -U fish_user_paths /usr/local/sbin /usr/local/bin /usr/bin

# disable start message
set -U fish_greeting

set -x RUST_SRC_PATH /usr/src/rust/src

# Use exa instead of ls
alias ls="exa"
alias ll="exa -l"

# create rmi
alias rmi="rm -i"

# cl
alias cl="cd $argv; and exa"

# Termcap is outdated, old, and crusty, kill it.
set -x TERMCAP

# Man is much better than us at figuring this out
set -x MANPATH
