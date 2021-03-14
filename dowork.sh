#/bin/sh

usage() { echo "Usage: $(basename $0) [-h] [-e] [-p abbre] dir abbre task"; exit 1;}

# The directory selected as a workspace,
# contains a list of symbolic links
# and a todo file named .todos

workspace=$HOME/work
todos=$workspace/.todos
[ -d $workspace ] || mkdir $workspace
[ -f $todos ] || touch $todos

# if no argument is set,
# print a list of tasks based .todos
if [ $# -eq 0 ]; then
	grep "^[[:alnum:]]*: " $todos | cat -n
	exit 0;
fi

# handle arguments
while getopts "p:he" opt; do
	case "$opt" in
	e)	# edit .todo files
		sb $todos
		exit 0
		;;
	p)	# print task's content relate to the directory
		abbre=$OPTARG
		task=`grep "^$abbre:" $todos | sed "s/^$abbre: //"`
		[ -z "$task" ] && usage
		echo $task
		exit 0;
		;;
	*)
		usage
		;;
	esac
done
shift $(expr $OPTIND - 1)

# make a symbolic link to $1,
# use $2 as a abbreviation to $1

[ $# -eq 3 ] || usage

be_worked=$(realpath $1)
[ -d $be_worked ] || usage

ln -s $be_worked $workspace/$2
echo "
$(date +"%d %B")
# $2 -> $be_worked
$2: $3
" >> $todos

