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

# Initialization

settings="$base"
macros="$exit_with_save"
abbres="$my_name"

# If view instead of edit
if [ $(basename $0) = sbv ]; then
	settings="$settings \
$readonly\
"
	macros="$macros\
|$exit_without_save\
"
fi

# Analyze filename 

case $1 in
*.w )
	use_web_mode
	;;
*.tex )
	use_tex_mode
	;;
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
*.md )
	use_markdown_mode
	;;
*.[1-9] )
	use_manpage_mode
	;;
*.asm )
	use_asm_mode
	;;
esac

# Analyze the first line of the file

first_line=
test -e $1  && first_line=$(head -n 1 $1)

case "$first_line" in
\#\!/*bin/*sh* )
	use_shell_mode
	;;
esac

# Start

debug=NO
#debug=YES
if [ $debug = 'YES' ]; then
	echo "se $settings" > ~/.exrc
	echo $macros | tr '|' '\n' >> ~/.exrc
	echo $abbres | tr '|' '\n' >> ~/.exrc
	vi "$@"
else
	env EXINIT="se $settings|$macros|$abbres|$EXINIT" vi "$@"
fi
