#/bin/sh

refs_path=~/ref

cd $refs_path
selected=$refs_path/$(echo * | tr ' ' '\n' | dmenu -l 5) 
[ $selected != $refs_path/ ] && mupdf-gl $selected

