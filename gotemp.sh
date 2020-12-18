#/bin/sh

dest=/mnt/tmp/temp

[ -d $dest ] || exit 1

for f in $@; do
	[ -d $f ] && tar -cf $f.tar $f &&\
		zip $f.tar.zip $f.tar && f=$f.tar.zip
	sudo cp $f $dest
done

