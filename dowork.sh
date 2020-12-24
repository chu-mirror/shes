#/bin/sh

# The directory selected as a workspace,
# contains a list of symbolic links
# and a todo file naming .todos

work_space=$HOME/work
[ -d $work_space ] || mkdir $work_space

# If no auguments is specified,
# print a todo-list basing on 
# the todo file

if [ $# -eq 0 ]; then
	todo_list=$work_space/.todos
	grep '^[a-zA-Z\-]*:' $todo_list | cat -n

	exit 0
fi

# Or make a symbolic link to $1,
# if $2 is specified, 
# use it as a abbreviation to $1

be_worked=$(realpath $1)
[ -d $be_worked ] || exit 1

ln -s $be_worked $work_space/$2

