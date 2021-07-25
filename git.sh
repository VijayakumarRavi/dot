#! /bin/bash

git_auto() {
	add=$1
	com=$2
	#if [[ $add=="" ]] || [[ $add==" " ]]; then
	#	add="."
	#fi
	echo "Add: " $add
	echo "Com: " $com
	sleep 5
	git add $add
	git commit -m "$com"
}
