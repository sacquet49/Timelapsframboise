#!/bin/bash

DATE=$(date +"%Y-%m-%d_%H%M")
LOG="/var/log/picam/driveClean.log"
SCRIPT_DIR="$( cd "$( dirname "$0" )" && pwd )"

echo $(date +"%Y-%m-%d_%H:%M:%S")" : INFO : Début suppression image du drive" >> $LOG

rclone --min-age 24h delete drive:Catcam/Pi2
rclone --min-age 24h delete drive:Catcam/Pi3

echo $(date +"%Y-%m-%d_%H:%M:%S")" : INFO : Fin suppression image du drive" >> $LOG