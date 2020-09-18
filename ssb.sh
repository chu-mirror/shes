#!/bin/sh

if [ -z $SHES_SOURCE_PATH ]; then
	echo "This script relies on the enviroment variable SHES_SOURCE_PATH, \
please specify it."
	exit 1
fi

next_paragraph='map  /^# [SMAIL][eabnto][dtcbia]'

macros="$next_paragraph\
"

cd $SHES_SOURCE_PATH
env EXINIT="$macros" sb sb.sh
sudo make install-sb

