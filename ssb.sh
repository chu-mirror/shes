#!/bin/sh

shes_path=~/src/shes

if [ -z $shes_path -o ! -d $shes_path ]; then
	echo "The shes_path is either not specified or not meaning a \
directory"
	exit 1
fi

[ ! -f $shes_path/sb.sh ] && echo "No sb.sh found" && exit 1

cd $shes_path

file_list=""
for arg in $@; do
	if [ -f "sbs/$arg" ]; then
		file_list="$file_list sbs/$arg"
	fi
done

pass=""
if [ -n "$file_list" ]; then
	pass='n'
fi


env EXINIT="$pass|$macros" sb sb.sh $file_list

echo "Install all changes? [Y/n]"
read do_install
case "$do_install" in
	[Yy]	) sudo make install-sb;;
	*	) ;;
esac

