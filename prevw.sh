#/bin/sh

dir=$(dirname $1)
file=$(basename $1)

suf=$(expr $file : '[[:graph:]]*\.\([[:alnum:]]*\)')
name=$(basename $file .$suf)

cd $dir

case $suf in
	'tex') echo '\end' | pdftex $file && mupdf-gl $name.pdf ;;
	'w' ) cweave $file; echo '\end' | pdftex $name.tex; mupdf-gl $name.pdf ;;
	[1-9] ) less $file ;;
esac
