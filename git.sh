#! /bin/bash

git_auto() {
	add=$1
	com=$2
	echo "Add: " $add
	echo "Com: " $com
	sleep 5
	git add $add
	git commit -m "$com"
}
