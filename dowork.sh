#/bin/sh

work_space=$HOME/work
[ -d $work_space ] || mkdir $work_space

be_worked=$(realpath $1)
[ -d $be_worked ] || exit 1

ln -s $be_worked $work_space/$2

