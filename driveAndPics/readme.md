
# Utilisation de rpicam-still pour la partie prise de photo 

````
$ rpicam-still -o image_infrarouge-test.jpg --tuning-file /usr/share/libcamera/ipa/rpi/vc4/imx219_noir.json --width 3280 --height 2464
$ rpicam-still -o image1.jpg --width 3280 --height 2464
````

# Utilisation de rclone pour synchronisé avec un drive.

````
$ rclone copy image_infrarouge-test.jpg drive:Catcam/
$ rclone copy image-test.jpg drive:Catcam/
````

# Depose des shell et attribution des bon droits 

````
sudo mkdir /etc/picam
sudo mkdir /var/log/picam
sudo chown user:user /var/log/picam
sudo chown user:user /etc/picam
sudo chmod +x /etc/picam/camera.sh
````

# Cron table 

Commande pour mettre à jour le Cron tab
````
$ sudo crontab -e
````

Pour la cameraIr
````
 * * * * * /etc/picam/camera_ir.sh 2>&1
 * 22-23,0-8 * * * /etc/picam/camera_ir.sh 2>&1
 */10 8-17 * * * /etc/picam/vid_ir.sh 2>&1
````

Pour la camera classic 
````
 * * * * * /etc/picam/camera.sh 2>&1
 * 8-22 * * * /etc/picam/camera.sh 2>&1
````

Pour la cleanDrive
````
 0 23 * * * /etc/picam/driveClean.sh 2>&1
````
