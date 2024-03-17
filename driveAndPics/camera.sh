#!/bin/bash

DATE=$(date +"%Y-%m-%d_%H%M")
LOG="/var/log/picam.log"
HOMEDIR=$( getent passwd "$USER" | cut -d: -f6 )
REPERTOIRESTOCKAGE=$HOMEDIR/capture/
NBPHOTO=6

echo $(date +"%Y-%m-%d_%H:%M:%S")" : INFO : Début prise de vue" >> $LOG
	
# Prend un nombre de prise de vue défini en parametrage
for numero in `seq 1 $NBPHOTO`
do
	DATEPHOTO=$(date +"%Y-%m-%d_%H%M%S")

	# Prend une photo
	rpicam-still -o $REPERTOIRESTOCKAGE/$DATEPHOTO.jpg --width 3280 --height 2464
	# rclone copy $REPERTOIRESTOCKAGE/$DATEPHOTO.jpg drive:Catcam/Pi3
			
	# Temps de pause entre chaque image
	sleep 4
done

echo $(date +"%Y-%m-%d_%H:%M:%S")" : INFO : Fin prise de vue" >> $LOG