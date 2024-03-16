Manuel installation timelaps sur Raspberry


Configuration d’un répertoire de partage

On crée le répertoire suivant :
# mkdir /home/pi/timelaps

Installation du package samba pour crée un partage unix vers windows.
# sudo apt-get install samba samba-common-bin

Edition de la confirguration :

# sudo nano /etc/samba/smb.conf

On décomente ces deux ligne et on vérifie leurs valeurs :
workgroup = WORKGROUP
wins support = yes
On ajoute la configuration suivante en pointant vers le répertoire crée

[PiShare]
comment=Raspberry time laps Share
path=/home/pi/timelaps
browseable=Yes
writeable=Yes
only guest=no
create mask=0774
directory mask=0774
public=no


Puis on enregistre le fichier, on crée ensuite un utilisateur samba qui accédera au partage. Cette utilisateur doit être un utilisateur du systeme, si se n’est pas le cas crée le avec la commande # sudo adduser « Utilisateur »

# sudo smbpasswd -a pi

On redémarre les services

# sudo /etc/init.d/samba restart

Voilà maintenant on a accès à un répertoire sur notre raspberry depuis windows.
Pour vérifier il nous suffit d’allez dans les favorie réseau de windows et de d’essayé de se connecter au raspberry. Normalement tous se passe bien. A l’ouverture on devrait voir notre répertoire de partage.



Creation d’un point de montage automatique

Dans votre windows préférer crée un répertoire ou vous le souhaiter, se répertoire le mettre en partage .
Voici les modification a faire sur le raspberry :
Crée un fichier qui va contenir votre user et votre mots de passe
# sudo nano /root/smbpass.conf
Ligne a mettre dans le fichier remplacer MyUsername et MyPassword
username=MyUsername
password=MyPassword
Mettre les autorisation au fichier
# sudo chmod 600 /root/smbpass.conf,
Crée un répertoire sur le raspberry qui va être le point cible du montage
# sudo mkdir /home/pi/partageDistant
Modifier le fichier fstab
# sudo nano /etc/fstab
Ajouter la ligne suivante
//NomHote/MonRepertoire /home/pi/partageDistant cifs credentials=/root/smbpass.conf 0 0
ex ://SACQUETPC/RaspImage /home/pi/partageImg cifs credentials=/root/smbpass.conf 0 0
Nouvelle configuration : //SACQUETPC/RaspImage /home/pi/partageImg cifs defaults,vers=2.0,credentials=/root/smbpass.conf 0 0
Puis sauvegarder.
Ensuite exécuter les commandes suivante :
# sudo mount //NomHote/MonRepertoire
# ls /home/pi/partageDistant
Si vous lister les fichier qui sont dans le répertoire Windows partager la conf est bonne.

Parametrage du bash de prise de vue

Copier les deux bash dans un répertoire commun.
Configuration du cron tab

# sudo sudo crontab -e

Copier la ligne suivante

* 7-23,0 * * * /home/pi/timelaps/camera.sh « cheminfichierParm » 2>&1

Mettre le bon chemin du script à la place. Le script va s’exécuter de de 7h a 1h du matin avec ces paramètre. Enregistrer vous pouvez redémarrer le raspberry. Maintenant plus qu’a patienter. Chaque minute une photo va être prise

Explication des bash

Le premier bash (camera.sh) va prendre une photo, la convertir pour qu’elle prenne moins de place.
Il va tenter de se connecter au répertoire de partage distant paramètre au dessus, si il y arrive il transférera l’image sur se répertoire. Se transfère s’effectue avec le second bash. Si se second batsh travail encore lorsque le premier bash est appeler par la tache cron, alors il n’est pas rappeler. Ont doit donnée en paramètre le répertoire du fichier de paramètrage.
Fichier de paramètrage parametre.sh
Se fichier est a changer en fonction de votre usage
#!/bin/bash

# Emplacement des fichiers de log
LOGREP="/home/pi/log"

# Chemin du partage distant (pc windows)
MOUNT="//SACQUETPC/RaspImage"

# Chemin local du répertoire dans lequelle on a monté le partage distant
PARTAGE="/home/pi/partageImg"

# Repertoire ou stoker les images
REPERTOIRESTOCKAGE="/home/pi/timelaps"

# Chemin du bash de déplacement des image vers le répertoire distant
DELACEMENT="/home/pi/timelaps/deplace.sh"

# Repertoire ou déplacer les images
REPERTOIRCIBLE="/home/pi/partageImg"

# Repertoire source des image
REPERTOIRESOURCE="/home/pi/timelaps"
