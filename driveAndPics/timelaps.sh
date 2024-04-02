#!/bin/bash

DATE=$(date +"%Y-%m-%d_%H%M")
LOG="/var/log/picam/timelaps.log"
SCRIPT_DIR="$( cd "$( dirname "$0" )" && pwd )"
REPERTOIRESTOCKAGE=$SCRIPT_DIR
NBPHOTO=10
# 58 minutes
# TEMPCAPTURE=3480000
# 2 minutes valeur de test
TEMPCAPTURE=120000

# Prend un nombre de prise de vue défini en parametrage
for numero in `seq 1 $NBPHOTO`
do
echo $(date +"%Y-%m-%d_%H:%M:%S")" : INFO : Début prise de vue" >> $LOG

  # Prend un nombre de prise de vue défini en parametrage
  DATEPHOTO=$(date +"%Y-%m-%d_%H%M%S")

  # Prend une photo, envoie drive et supprime en local
  echo $(date +"%Y-%m-%d_%H:%M:%S")" : INFO : Prise de vue $REPERTOIRESTOCKAGE/$DATEPHOTO.jpg" >> $LOG

  rpicam-still -q 90 -t $TEMPCAPTURE -o $REPERTOIRESTOCKAGE/$(date +"%Y-%m-%d_%H:%M:%S").jpg --timelapse 2000 --width 3280 --height 2464 --nopreview

  ffmpeg -r 25 -f image2 -pattern_type glob -i "$REPERTOIRESTOCKAGE/*.jpg" -s 1920x1080 -vcodec libx264 $REPERTOIRESTOCKAGE/$DATEPHOTO.mp4
  rclone copy $REPERTOIRESTOCKAGE/$DATEPHOTO.mp4 drive:Catcam/Pi3

  rm $REPERTOIRESTOCKAGE/*.jpg
  rm $REPERTOIRESTOCKAGE/$DATEPHOTO.mp4

  echo $(date +"%Y-%m-%d_%H:%M:%S")" : INFO : Fin prise de vue" >> $LOG

done