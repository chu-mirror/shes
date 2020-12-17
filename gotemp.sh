#/bin/sh

dest=/mnt/tmp/temp

[ -d $test ] || exit 1

for f in $@; do
	[ -d $f ] && tar -cf $f.tar.zip $f && f=$f.tar.zip
	cp $f $dest
done

