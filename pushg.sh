#!/bin/sh

make clean
[ -z "$1" ] ||\
git add . &&\
git commit -m "$1" 
git push origin master

