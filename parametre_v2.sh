#!/bin/bash

# Emplacement des fichiers de log
LOGREP="/home/pi/log"

# Chemin du partage distant (pc windows)
MOUNT="//SACQUETPC/RaspImage"

# Chemin local du répertoire dans lequelle on a monté le partage distant
PARTAGE="/home/pi/partageImg/test"

# Repertoire ou stoker les images
REPERTOIRESTOCKAGE="/home/pi/test"

# Chemin du bash de déplacement des image vers le répertoire distant
DELACEMENT="/home/pi/timelaps/deplace_v2.sh"

# Repertoire ou déplacer les images
REPERTOIRCIBLE="/home/pi/partageImg/test"

# Repertoire source des images
REPERTOIRESOURCE="/home/pi/test"

# Temps de pause entre chaque image 0 par defaut
TPSPAUSE=4

# Nombre d'image voulu
NBPHOTO=10