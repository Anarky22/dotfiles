#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

#create rmi alias for mm
alias rmi='rm -i'

#cd and ls in 1
cl() {
        local dir="$1"
        local dir="${dir:=$HOME}"
        if [[ -d "$dir" ]]; then
                cd "$dir" >/dev/null; ls
        else
                echo "bash: cl: $dir: Directory not found"
        fi
}

#make directory and cd in
md() {
        local dir="$1"
        mkdir "$dir"
        cd "$dir"
}


#FZF Functions
# fe [FUZZY PATTERN] - Open the selected file with the default editor
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
fe() {
  local files
  IFS=$'\n' files=($(fzf-tmux --query="$1" --multi --select-1 --exit-0))
  [[ -n "$files" ]] && ${EDITOR:-nvim} "${files[@]}"
}

# fda - cd to selected directory including hidden directories
fda() {
  local dir
  dir=$(find ${1:-.} -type d 2> /dev/null | fzf +m) && cd "$dir"
}

# cdf - cd into the directory of the selected file
cdf() {
   local file
   local dir
   file=$(fzf +m -q "$1") && dir=$(dirname "$file") && cd "$dir"
}

# ftags - search ctags
ftags() {
  local line
  [ -e tags ] &&
  line=$(
    awk 'BEGIN { FS="\t" } !/^!/ {print toupper($4)"\t"$1"\t"$2"\t"$3}' tags |
    cut -c1-80 | fzf --nth=1,2
  ) && ${EDITOR:-vim} $(cut -f3 <<< "$line") -c "set nocst" \
                                      -c "silent tag $(cut -f2 <<< "$line")"
}

#Shell Bookmarks with fzf
#Bookmark paths are stored in ~/.fzf_bm_paths
fbm() {
        local dest_dir
        if [ -r ~/.fzf_bm_paths ]; then
               dest_dir=$(cat ~/.fzf_bm_paths | sed '/^\s*$/d' | fzf)
        fi
        if [[ $dest_dir != '' ]]; then
                eval cl "$dest_dir"
        fi
}
 


[ -f ~/.fzf.bash ] && source ~/.fzf.bash
