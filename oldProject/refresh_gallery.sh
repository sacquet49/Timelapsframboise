#!/bin/bash

. $1/parametre_v2.sh

DATEIMAGE=$(date -d '1 hour ago' "+%Y-%m-%d_%H%M%S")
LOG="$LOGREP/refresh.log"
REPERTOIRESOURCE="$REPERTOIRCIBLE/*.jpg"
REPERTOIRCIBLE=/home/pi/archive/

echo $(date +"%Y-%m-%d_%H:%M:%S")" : INFO : Début déplacement archive" >> $LOG

# Liste les image dans le repertoire source
LISTEIMG=$(find $REPERTOIRESOURCE -mmin +59)

for IMAGE in $LISTEIMG; do
	echo $(date +"%Y-%m-%d_%H:%M:%S")" : "$IMAGE >> $LOG
	mv $IMAGE $REPERTOIRCIBLE
	RETOUR=`echo $?`
	if [ "$RETOUR" -gt 0 ]; then
		echo $(date +"%Y-%m-%d_%H:%M:%S")" : ERROR : Déplacement du fichier imposible" >> $LOG
	fi
done

cd /var/www/html/picamview/
php bin/console cache:clear --env=prod

chmod -R 777 /var/www/html/picamview/var/session/
chmod -R 777 /var/www/html/picamview/var/cache/
chmod -R 777 /var/www/html/picamview/var/logs/

echo $(date +"%Y-%m-%d_%H:%M:%S")" : INFO : Fin déplacement archive" >> $LOG