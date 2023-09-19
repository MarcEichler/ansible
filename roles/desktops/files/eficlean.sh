#!/bin/zsh

entries=()

while read -r line
do
	echo "--- Processing $line"

	name=$(echo "$line" | awk '{$1=""; print $0}')
	echo "Name: $name"

	if [[ "${entries[@]}" =~ "(${name})" ]]; then
		num=$(expr $(echo "$line" | awk '{print $1}') : 'Boot\([[:digit:]|ABCDEF]*\)[\*]*')
		echo "Second occurence, deleting $num."
		efibootmgr -b $num -B
	else
		echo "First occurence"
		entries+="($name)"
	fi
done < <(efibootmgr | tail -n +4)
