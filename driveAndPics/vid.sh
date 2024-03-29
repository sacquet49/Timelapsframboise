#!/bin/bash

DATE=$(date +"%Y-%m-%d_%H%M")
LOG="/var/log/picam/picamVid.log"
SCRIPT_DIR="$( cd "$( dirname "$0" )" && pwd )"
REPERTOIRESTOCKAGE=$SCRIPT_DIR

echo $(date +"%Y-%m-%d_%H:%M:%S")" : INFO : Début prise de vue" >> $LOG
DATEPHOTO=$(date +"%Y-%m-%d_%H%M%S")

# Prend une video, envoie drive et supprime en local
echo $(date +"%Y-%m-%d_%H:%M:%S")" : INFO : Prise de vue $REPERTOIRESTOCKAGE/$DATEPHOTO.mkv" >> $LOG

rpicam-vid -o $REPERTOIRESTOCKAGE/$DATEPHOTO.h264 --framerate 35 -t 100000 --hdr --width 720 --height 480 --save-pts $REPERTOIRESTOCKAGE/$DATEPHOTO.txt --nopreview
mkvmerge -o $REPERTOIRESTOCKAGE/$DATEPHOTO.mkv --timecodes 0:$REPERTOIRESTOCKAGE/$DATEPHOTO.txt $REPERTOIRESTOCKAGE/$DATEPHOTO.h264

rclone copy $REPERTOIRESTOCKAGE/$DATEPHOTO.mkv drive:Catcam/Pi2

rm $REPERTOIRESTOCKAGE/$DATEPHOTO.h264
rm $REPERTOIRESTOCKAGE/$DATEPHOTO.txt
rm $REPERTOIRESTOCKAGE/$DATEPHOTO.mkv

echo $(date +"%Y-%m-%d_%H:%M:%S")" : INFO : Fin prise de vue" >> $LOG
