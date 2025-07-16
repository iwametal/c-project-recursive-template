#!/usr/bin/bash

# COLORS
LILAC="\033[01;36m"
BLUE="\033[01;34m"
RESET_COLOR="\e[0m"

project_name=
default_compiler="gcc"
default_std="gnu99"

while [ -z "$project_name" ]; do
	echo -en "$LILAC""[Enter your project name]: ""$RESET_COLOR"
	read project_name
done

echo "PROJECT NAME: $project_name"
echo "Adding project name"
sed -i 's/project_name/'$projec_name'/g' project.conf
echo "Adding path for the project"
sed -i 's/~\/path\/to/'$(pwd | sed 's,/*[^/]\+/*$,,' | sed 's/\//\\\//g')'/g' project.conf

echo -en "$LILAC""[Enter your compiler name or Enter to keep default] ""$BLUE""[Default: gcc]: ""$RESET_COLOR"
read compiler

[ -n "$compiler" ] && [ $compiler != $default_compiler ] && echo "Adding compiler {$compiler}" && sed -i 's/export CC := gcc/export CC := '$compiler'/g' Makefile

echo -en "$LILAC""[Enter the language standards for your compiler or Enter to keep default] ""$BLUE""[Default: gnu99]: ""$RESET_COLOR"
read std

[ -n "$std" ] && [ $std != $default_std ] && echo "Adding language standards for the compiler {$std}" && sed -i 's/STD := -std=gnu99/STD := '$std'/g' Makefile

echo -e "$LILAC""[Project Base Configured]""$RESET_COLOR"
echo "Do not forget to take a look in ""$BLUE""Makefile ""$RESET_COLOR""for additional ""$BLUE""Flags""$RESET_COLOR"" and ""$BLUE""Configurations""$RESET_COLOR"