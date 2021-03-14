#!/bin/sh

# if no directory is specified,
# use $HOME/ref as the default
ref_path=${1:-$HOME/ref}
[ -d "$ref_path" ] || mkdir -p "$ref_path"
cd "$ref_path"

# select an entry from dmenu
selected=$ref_path/$(echo * | tr ' ' '\n' | dmenu -l 5) 

# if the entry is a directory,
# invoke ref again on that directory
[ "$selected" != $ref_path/ ] && { \
	if [ -d "$selected" ]; then 
		ref "$selected" 
	else 
		mupdf-gl "$selected"
	fi
}

