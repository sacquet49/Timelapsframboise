
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