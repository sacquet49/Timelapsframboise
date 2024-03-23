#!/bin/bash

DATE=$(date +"%Y-%m-%d_%H%M")
LOG="/var/log/picam/picamVid.log"
SCRIPT_DIR="$( cd "$( dirname "$0" )" && pwd )"
REPERTOIRESTOCKAGE=$SCRIPT_DIR

echo $(date +"%Y-%m-%d_%H:%M:%S")" : INFO : Début prise de vue" >> $LOG
DATEPHOTO=$(date +"%Y-%m-%d_%H%M%S")

# Prend une video, envoie drive et supprime en local
echo $(date +"%Y-%m-%d_%H:%M:%S")" : INFO : Prise de vue $REPERTOIRESTOCKAGE/$DATEPHOTO.mkv" >> $LOG

rpicam-vid --framerate 25 --profile baseline -t 100000 -o $REPERTOIRESTOCKAGE/$DATEPHOTO.h264 --tuning-file /usr/share/libcamera/ipa/rpi/vc4/imx219_noir.json \
--save-pts $REPERTOIRESTOCKAGE/$DATEPHOTO.txt --nopreview
# Avec des paramètres optimisé mais il faut avoir des led IR pour que le capteur soit sensible dans le noir
# rpicam-vid -o $REPERTOIRESTOCKAGE/$DATEPHOTO.h264 --framerate 25 --profile baseline -t 100000 --tuning-file /usr/share/libcamera/ipa/rpi/vc4/imx219_noir.json \
# -t 1000000 --width 1920 --height 1080 --saturation 0 --ev 1 --awb cloudy --save-pts $REPERTOIRESTOCKAGE/$DATEPHOTO.txt --nopreview
mkvmerge -o $REPERTOIRESTOCKAGE/$DATEPHOTO.mkv --timecodes 0:$REPERTOIRESTOCKAGE/$DATEPHOTO.txt $REPERTOIRESTOCKAGE/$DATEPHOTO.h264

rclone copy $REPERTOIRESTOCKAGE/$DATEPHOTO.mkv drive:Catcam/Pi2

rm $REPERTOIRESTOCKAGE/$DATEPHOTO.h264
rm $REPERTOIRESTOCKAGE/$DATEPHOTO.txt
rm $REPERTOIRESTOCKAGE/$DATEPHOTO.mkv

echo $(date +"%Y-%m-%d_%H:%M:%S")" : INFO : Fin prise de vue" >> $LOG
