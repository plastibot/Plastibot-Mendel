#!/bin/bash

#########################################################
#INSTRUCTIONS:
#Save this file in your home directory /home/pi
#Go to your home directory /home/pi
#Run this in command line on Raspberry Pi:
#chmod +x OctoPrintInstall.sh; ./OctoprintInstall.sh
#
#NOTES:
#If your home directory is not "pi", then your
#CuraEngine plugin settings need to be changed to say /home/whatever
#########################################################


apt-get update
apt-get install -y python2.7 python-pip python-setuptools cmake gcc gcc++ python-numpy git freecad

#OctoPrint
git clone https://github.com/foosel/OctoPrint.git ~/OctoPrint
cd ~/OctoPrint
python setup.py install
cp ~/OctoPrint/scripts/octoprint.init /etc/init.d/octoprint
chmod +x /etc/init.d/octoprint
cp ~/OctoPrint/scripts/octoprint.default /etc/default/octoprint
update-rc.d octoprint defaults
pip install https://github.com/markwal/OctoPrint-SnapStream/archive/master.zip

#CuraEngine
apt-get -y install gcc-4.7 g++-4.7
git clone -b legacy https://github.com/Ultimaker/CuraEngine.git ~/CuraEngine
cd ~/CuraEngine
wget http://bit.ly/curaengine_makefile_patch -O CuraEngine.patch
patch < CuraEngine.patch
make CXX=g++-4.7

#Mpeg-streamer
apt-get -y install libjpeg8-dev imagemagick libv4l-dev make gcc git cmake g++
git clone https://github.com/jacksonliam/mjpg-streamer.git /Github
cd ~/mjpg-streamer/mjpg-streamer-experimental/
cmake -G "Unix Makefiles"
make
mkdir /usr/local/mjpg-streamer
cp mjpg_streamer /usr/local/mjpg-streamer
cp output_http.so input_file.so input_uvc.so /usr/local/mjpg-streamer
cp -r www /usr/local/mjpg-streamer
cd /usr/local/mjpg-streamer
./mjpg_streamer -i "/usr/local/mjpg-streamer/input_uvc.so" -o "/usr/local/mjpg-streamer/output_http.so -w /usr/local/mjpg-streamer/www" -b
cd /etc/init.d
wget http://www.repetier-server.com/en/software/extras/mjpgstreamer-init-debian/mjpgstreamer
chmod 755 mjpgstreamer
update-rc.d mjpgstreamer defaults

#Instructions
echo "Plastibot 3D Printer
--------------------
Instructions:
User: pi
Pass: plastibot

To start Octoprint: open a browser and go to http://localhost:5000
Connect the computer and the raspberry pi to the same network.

To create a new slicing profile for Octoprint, use the file system to find ~/Slice.
This folder contains slicing profiles. Don't edit them, but save a copy. Then edit the copy.
When finished editing the profile, use Octoprint -> Settings -> CuraEngine -> Import Profile to upload it.
Then make sure to Save your settings.

To modify firmware:
Open Arduino
Find Marlin in the sketchbook
The sketchbook is located in the home directory of the raspberry pi.
" > ~/Desktop/Instructions.txt



#Shortcut Setup
echo "[Desktop Entry]
Name=OctoPrint
Exec=epiphany http://localhost:5000
" > ~/Desktop/OctoPrint.destkop



#Network Setup
echo "auto lo
iface lo inet loopback
#iface eth0 inet dhcp

iface eth0 inet static
address 172.16.80.236
netmask 255.255.255.0
gateway 172.16.80.254

allow-hotplug wlan0
iface wlan0 inet dhcp
wpa-conf /etc/wpa_supplicant/wpa_supplicant.conf
" > /etc/network/interfaces