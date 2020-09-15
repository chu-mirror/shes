#!/bin/sh

# This is my new attempt at editing, which is based on two concepts,
# primitive and mode.
# 
# 	Primitive: macros, abbreviations, or settings provided by
# 	editor, vi/ex here.
# 
# 	Mode: combinations of primitives, differ from one file type
# 	to another, strictly, using "file type" here is not correct,
# 	for you can have a mode in morning and another night.
# 
# The choice of editor is still under consideration, but the shell/vi
# implementation works well by now.
# 
# The way to add a extension under this framework is ultimately simple,
# 	1. Write the primitive.
# 	2. Add it to the corresponding mode.
# or mode,
# 	1. Create a new mode by collecting primitives.
# 	2. Write code to decide when to activate it.
#
# This project is compeletly personal, if of interest to you, create 
# one yourself.
#
# Finaly, I should confess that it's not something grandly new, or even
# maybe a common use of vi/ex. But I enjoy it, and want to share with
# everyone my enjoyment.

# Ignorecase and autowrite 
base="ic aw"

# Two kinds of programming 
struct_prog="ai"
lisp_prog="ai lisp" 	# This option has not been implemented yet
			# in nvi.
			# Maybe I can do that?

# Macros for input mode 

new_block_brace='map!  {}O	'
new_block_begin_end='map!  beginendO	'

comment_brace='map!  {}i'
comment_dq_to_sharp='map!  :?^"$?+1,.-1s/^/# /:\?d:\/d' 
	#dq: doublequote

# Macros for commond mode

exit_with_save='map q :wq'
compile='map #5 :!make'

# Abbreviations
my_name='ab mzz Maeda Chu'
use_posix_shell='ab ush #!/bin/sh'
include_stdio='ab iio #include <stdio.h>'


# Modes

shell_mode=NO
use_shell_mode() {
	if [ $shell_mode = YES ]; then
		return 0
	fi
	shell_mode=YES

	settings="$settings \
$struct_prog\
"

	macros="$macros\
|$new_block_brace\
|$comment_dq_to_sharp\
"

	abbres="$abbres\
|$use_posix_shell\
"
}

make_mode=NO
use_make_mode() {
	if [ $make_mode = YES ]; then
		return 0
	fi
	make_mode=YES

	settings="$settings \
$struct_prog\
"

	macros="$macros\
|$new_block_brace\
"
	ajbbres="$abbres\
"
}

c_mode=NO
use_c_mode() {
	if [ $c_mode = YES ]; then
		return 0
	fi
	c_mode=YES

	settings="$settings \
$struct_prog\
"

	macros="$macros\
|$new_block_brace\
"

	abbres="$abbres\
|$include_stdio\
"
}

lisp_mode=NO
use_lisp_mode() {
	if [ $lisp_mode = YES ]; then
		return 0
	fi
	lisp_mode=YES

	settings="$settings \
$lisp_prog\
"

	macros="$macros\
"
	
	abbres="$abbres\
"
}

pascal_mode=NO
use_pascal_mode() {
	if [ $pascal_mode = YES ]; then
		return 0
	fi
	pascal_mode=YES

	settings="$settings \
$struct_prog\
"

	macros="$macros\
|$comment_brace\
|$new_block_begin_end\
|$compile\
"
	
	abbres="$abbres\
"
}

# Initialization

settings="$base"
macros="$exit_with_save"
abbres="$my_name"

# Analyze filename 

case $1 in
*.c | *.h ) 
	use_c_mode
	;;
*.sh | .shrc | .profile ) 
	use_shell_mode
	;;
[mM]akefile )
	use_make_mode
	;;
*.pp | *.pas | *.p )
	use_pascal_mode
	;;
*.lisp ) 
	use_lisp_mode
	;;
esac

# Analyze the first line of the file

first_line=
[ -e $1 ] && first_line=$(head -n 1 $1)

case "$first_line" in
\#\!/*bin/*sh* )
	use_shell_mode
	;;
esac

debug=NO
#debug=YES
if [ $debug = 'YES' ]; then
	echo "se $settings" > ~/.exrc
	echo $macros | tr '|' '\n' >> ~/.exrc
	echo $abbres | tr '|' '\n' >> ~/.exrc
	vi "$@"
else
	env EXINIT="se $settings|$macros|$abbres" vi "$@"
fi

