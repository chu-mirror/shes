#!/bin/sh

message=$(dowork | grep "$1" | sed "s/^.*: //")

make clean
git add . &&\
git commit -m "${message:-$2}" &&\
[ -n $3 ] ||\
git push origin master

