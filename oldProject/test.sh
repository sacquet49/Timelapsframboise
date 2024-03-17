#!/bin/bash

# if [ -z $1 ]
# then
	# echo $(date +"%Y-%m-%d_%H:%M:%S")" ERROR : Aucun fichier de parametrage !" 
# fi
# echo $1
# . $1/parametre.sh

LOG="$LOGREP/test.log"

# DATE=$(date +"%Y-%m-%d_%H%M")
# DELACEMENT="/home/pi/timelaps/deplace.sh"
# JOUR=$(date +"%d")
# JOURHEUREMINUTE=$(date +"%d%H%M")
# APREMINUIT=true

# HEUREMIN=$JOUR'0730'
# HEUREMAXAFTER=$JOUR'0100'

# Si parametre après minuit on ajoute un jour
# if [ $APREMINUIT == true ]
# then
	# JOUR=$(date --date="1 days" +"%d")
# fi
# HEUREMAX=$JOUR'0100'

# if [[ ( $JOURHEUREMINUTE  -gt $HEUREMIN )  && ( $JOURHEUREMINUTE  -gt $HEUREMAXAFTER  ||  $JOURHEUREMINUTE  -lt $HEUREMAXAFTER ) ]]
# then
	# Prend un photo
	# echo "toto"
# fi

# Regarde les processus root
# RESULT=$(ps -fu root)
# Cherche le traitement n'est pas dans les processus
# RESULT=$(echo $RESULT | grep $DELACEMENT)
# Si on trouve pas le traitement on le lance
# if $RESULT; then
	# echo $DATE" : Lancement traitement"
	# $DELACEMENT
# else
	# echo $DATE" : Traitement en cours"
# fi

# echo $DATE" : Fin principal"

# echo $(date +"%Y-%m-%d_%H:%M:%S")" : Répertoire bash : $MOUNT " >> $LOG
# echo $(date +"%Y-%m-%d_%H:%M:%S")" : Répertoire source image : $PARTAGE " >> $LOG
# echo $(date +"%Y-%m-%d_%H:%M:%S")" : Point de montage :  $DELACEMENT ">> $LOG

NBPHOTOMIN=30
if [ $NBPHOTOMIN -gt 60 ]; then
		echo $(date +"%Y-%m-%d_%H:%M:%S")" : ERROR : Imposible de prendre des vue au dela de 60"
fi

