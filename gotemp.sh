#/bin/sh

dest=/mnt/tmp/temp
storage=/dev/sdb1

[ -d $dest ] || \
[ -e $storage ] && sudo mount $storage $(dirname $dest)

[ $# -eq 0 ] && cp $dest/* .

for f in $@; do
	[ -d $f ] && tar -cf $f.tar $f && \
		zip $f.tar.zip $f.tar && f=$f.tar.zip
	sudo cp $f $dest
done

sudo umount $(dirname $dest)

