#!/bin/sh

message=$(dowork | grep "$1" | sed "s/^.*: //")

make clean
git add . &&\
git commit -m "${message:-$1}" &&\
git push origin master

