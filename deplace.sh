#!/bin/bash

. $1/parametre.sh

LOG="$LOGREP/deplace.log"
REPERTOIRCIBLE=$REPERTOIRCIBLE
REPERTOIRESOURCE="$REPERTOIRESOURCE/*.jpg"

echo $(date +"%Y-%m-%d_%H:%M:%S")" : INFO : Début déplacement" >> $LOG

# Liste les image dans le repertoire source
LISTEIMG=$(ls $REPERTOIRESOURCE)

for IMAGE in $LISTEIMG; do
	echo $(date +"%Y-%m-%d_%H:%M:%S")" : "$IMAGE >> $LOG
	mv $IMAGE $REPERTOIRCIBLE
	RETOUR=`echo $?`
	if [ "$RETOUR" -gt 0 ]; then
		echo $(date +"%Y-%m-%d_%H:%M:%S")" : ERROR : Déplacement du fichier imposible" >> $LOG
	fi
done

echo $(date +"%Y-%m-%d_%H:%M:%S")" : INFO : Fin déplacement" >> $LOG