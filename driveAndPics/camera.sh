#!/bin/bash

DATE=$(date +"%Y-%m-%d_%H%M")
LOG="/var/log/picam/picam.log"
SCRIPT_DIR="$( cd "$( dirname "$0" )" && pwd )"
REPERTOIRESTOCKAGE=$SCRIPT_DIR
NBPHOTO=1

echo $(date +"%Y-%m-%d_%H:%M:%S")" : INFO : Début prise de vue" >> $LOG
	
# Prend un nombre de prise de vue défini en parametrage
for numero in `seq 1 $NBPHOTO`
do
	DATEPHOTO=$(date +"%Y-%m-%d_%H%M%S")

	# Prend une photo, envoie drive et supprime en local
	echo $(date +"%Y-%m-%d_%H:%M:%S")" : INFO : Prise de vue $REPERTOIRESTOCKAGE/$DATEPHOTO.jpg" >> $LOG
	rpicam-still -q 90 -o $REPERTOIRESTOCKAGE/$DATEPHOTO.jpg --exposure long --nopreview --width 3280 --height 2464
	rclone copy $REPERTOIRESTOCKAGE/$DATEPHOTO.jpg drive:Catcam/Pi3
	rm $REPERTOIRESTOCKAGE/$DATEPHOTO.jpg
done

echo $(date +"%Y-%m-%d_%H:%M:%S")" : INFO : Fin prise de vue" >> $LOG
