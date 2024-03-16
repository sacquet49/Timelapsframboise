#!/bin/bash

DATE=$(date +"%Y-%m-%d_%H%M")
LOG="/home/pi/log/default.log"

if [ -z $1 ]
then
	echo $(date +"%Y-%m-%d_%H:%M:%S")" ERROR : Aucun fichier de parametrage !" >> $LOG
else

	. $1/parametre_v2.sh
	
	LOG=$LOGREP/camera.log

	echo $(date +"%Y-%m-%d_%H:%M:%S")" : INFO : Début prise de vue" >> $LOG
	
	# Prend un nombre de prise de vue défini en parametrage
	for numero in `seq 1 $NBPHOTO`
	do 	
		DATEPHOTO=$(date +"%Y-%m-%d_%H%M%S")
			
		# Prend une photo
		raspistill -q 90 -o $REPERTOIRESTOCKAGE/$DATEPHOTO.jpg
		
		cp $REPERTOIRESTOCKAGE/$DATEPHOTO.jpg /var/www/html/picamview/web/images/lastImage.jpg

		# Reduit la taille de l'image
		# convert -quality 90 $REPERTOIRESTOCKAGE/$DATEPHOTO.jpg $REPERTOIRESTOCKAGE/$DATEPHOTO.jpg
			
		# Temps de pause entre chaque image
		sleep $TPSPAUSE
	done

	# Regarde les processus root
	RESULT=$(ps -fu root)
	# Cherche le traitement n'est pas dans les processus
	RESULT=$(echo $RESULT | grep $DELACEMENT)
			
	# Si on trouve pas le traitement de déplacement on le lance
	if $RESULT; then
		echo $(date +"%Y-%m-%d_%H:%M:%S")" : INFO : Lancement déplacement des images" >> $LOG
		# Si le partage est actif on deplace toute les image du répertoire local sur le partage
		$DELACEMENT $1
	else
		echo $(date +"%Y-%m-%d_%H:%M:%S")" : INFO : Déplacement d'image en cours" >> $LOG
	fi

	echo $(date +"%Y-%m-%d_%H:%M:%S")" : INFO : Fin prise de vue" >> $LOG
fi