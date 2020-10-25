#!/bin/sh

if [ -z $SHES_SOURCE_PATH -o ! -d $SHES_SOURCE_PATH ]; then
	echo "The SHES_SOURCE_PATH is either not specified or not meaning a \
directory"
	exit 1
fi

[ ! -f $SHES_SOURCE_PATH/sb.sh ] && echo "No sb.sh found" && exit 1


cd $SHES_SOURCE_PATH
env EXINIT="$macros" sb sb.sh
sudo make install-sb

