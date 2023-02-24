#!/bin/sh
if [ "$1x" = "x" ] 
then
	echo folder name missing 
	echo should be "kt" or "names" or "other"
	exit
fi 


for i in *.md 
do
	base=${i%.md}
	file="./bible/$1/$i"
	echo "insert into tw_tbl (category,name,file)" 
	echo "values ('$1','$base', readfile('$file') );"
done


# https://stackoverflow.com/questions/125281/how-do-i-remove-the-file-suffix-and-path-portion-from-a-path-string-in-bash
