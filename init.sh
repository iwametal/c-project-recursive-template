#!/usr/bin/bash

if [ -n "$1" ] ; then
	sed -i 's/project_name/'$1'/g' project.conf

	sed -i 's/~\/path\/to/'$(pwd | sed 's,/*[^/]\+/*$,,' | sed 's/\//\\\//g')'/g' project.conf

else
	echo "Please, provide the name of your Project as an argument"
fi