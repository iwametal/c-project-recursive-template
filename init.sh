#!/usr/bin/bash

# COLORS
LILAC="\033[01;36m"
BLUE="\033[00;34m"
LIGHT_BLUE="\033[01;34m"
LIGHT_PURPLE="\033[01;35m"
RESET_COLOR="\e[0m"

project_name=
default_compiler="gcc"
default_std="gnu99"

while [ -z "$project_name" ]; do
	echo -en "$LILAC""[Enter your project name]: ""$RESET_COLOR"
	read project_name

	[ -e "./../$project_name" ] && echo "There is already a folder or file named $project_name in the current directory ($(pwd | sed 's,/*[^/]\+/*$,,'))" && project_name=''
done

echo "Reseting project configuration file..."
cp -f ./resources/makefile/conf/project.conf ./project.conf

echo "Adding project name {$project_name}..."
mv -f ../$(echo "${PWD##*/}") ../$project_name
sed -i 's/project_name/'$project_name'/g' project.conf

echo "Adding path for the project {$(pwd)}..."
sed -i 's/~\/path\/to/'$(pwd | sed 's,/*[^/]\+/*$,,' | sed 's/\//\\\//g')'/g' project.conf

echo -en "$LILAC""[Enter your compiler name or Enter to keep default] ""$BLUE""[Default: gcc]: ""$RESET_COLOR"
read compiler

[ -n "$compiler" ] && [ $compiler != $default_compiler ] && echo "Adding compiler {$compiler}..." && sed -i 's/export CC := gcc/export CC := '$compiler'/g' Makefile

echo -en "$LILAC""[Enter the language standards for your compiler or Enter to keep default] ""$BLUE""[Default: gnu99]: ""$RESET_COLOR"
read std

[ -n "$std" ] && [ $std != $default_std ] && echo "Adding language standards for the compiler {$std}..." && sed -i 's/STD := -std=gnu99/STD := -std='$std'/g' Makefile

echo -e "\n\n""$LIGHT_BLUE""[Project Base Configured]""$RESET_COLOR"
echo -e "Do not forget to take a look in ""$LIGHT_PURPLE""Makefile ""$RESET_COLOR""for additional ""$LIGHT_PURPLE""Flags and Configurations""$RESET_COLOR"