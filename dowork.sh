#/bin/sh

# The directory selected as a workspace,
# contains a list of symbolic links
# and a todo file named .todos

workspace=$HOME/work
todos=$workspace/.todos
[ -d $workspace ] || mkdir $workspace

# If no auguments is specified,
# print a todo-list basing on 
# the todo file

if [ $# -eq 0 ]; then
	grep '^[a-zA-Z][a-zA-Z\-]*:' $todos | cat -n
	exit 0
fi

# Or make a symbolic link to $1,
# use $2 as a abbreviation to $1

be_worked=$(realpath $1)
[ -d $be_worked ] || exit 1

ln -s $be_worked $workspace/$2
echo "
$(date "+ %d %B")
# $2 -> $be_worked
$(basename $be_worked): $3
" >> $todos

