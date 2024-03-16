#!/bin/bash

DATEIMAGE=$(date -d '1 hour ago' "+%Y-%m-%d_%H%M%S")

LISTEIMG=$(ls img/*jpg)

for IMAGE in $LISTEIMG; do
	if [ $IMAGE -ge $DATEIMAGE ];
	then
		echo $IMAGE
	fi 
done