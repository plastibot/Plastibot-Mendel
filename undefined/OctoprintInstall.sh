#!/bin/bash
#This uses a local IP Address of 172.16.80.236

#########################################################
#INSTRUCTIONS:
#Connect the Raspberry Pi to the internet using an ethernet cord
#Save this file anywhere on your Raspberry Pi
#Go to the folder where you saved this file
#Run this in the command line on Raspberry Pi:
#
#sudo chmod +x OctoPrintInstall.sh; sudo ./OctoprintInstall.sh
#
#########################################################

############################
#NOTES:
#To reset octoprint type:
#sudo service octoprint restart
#
############################


apt-get update
apt-get install -y python2.7 python-pip python-setuptools cmake gcc gcc++ python-numpy git freecad

#OctoPrint
git clone https://github.com/foosel/OctoPrint.git /usr/share/OctoPrint
cd /usr/share/OctoPrint
python setup.py install
cp /usr/share/OctoPrint/scripts/octoprint.init /etc/init.d/octoprint
chmod +x /etc/init.d/octoprint
cp /usr/share/OctoPrint/scripts/octoprint.default /etc/default/octoprint
update-rc.d octoprint defaults
pip install https://github.com/markwal/OctoPrint-SnapStream/archive/master.zip

#CuraEngine
apt-get -y install gcc-4.7 g++-4.7
git clone -b legacy https://github.com/Ultimaker/CuraEngine.git /usr/share/CuraEngine
cd /usr/share/CuraEngine
wget http://bit.ly/curaengine_makefile_patch -O CuraEngine.patch
patch < CuraEngine.patch
make CXX=g++-4.7

#Mpeg-streamer
apt-get -y install libjpeg8-dev imagemagick libv4l-dev make gcc git cmake g++
git clone https://github.com/jacksonliam/mjpg-streamer.git /usr/share/mjpg-streamer
cd /usr/share/mjpg-streamer/mjpg-streamer-experimental/
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

To start Octoprint: open a browser and go to http://localhost:5000
Connect the computer and the raspberry pi to the same network.

To create a new slicing profile for Octoprint, use the file system to find /usr/share/Slice.
This folder contains slicing profiles. Don't edit them, but save a copy. Then edit the copy.
When finished editing the profile, use Octoprint -> Settings -> CuraEngine -> Import Profile to upload it.
Then make sure to Save your settings.

To modify firmware:
Open Arduino
Find Marlin in the sketchbook
The sketchbook is located in the home directory of the raspberry pi.
" > /home/pi/Desktop/Instructions.txt



#Shortcut Setup
echo "[Desktop Entry]
Name=OctoPrint
Exec=epiphany http://localhost:5000
" > /home/pi/Desktop/OctoPrint.destkop



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



#Users Setup
echo "pi:
  active: true
  apikey: null
  password: acfd335bc532d570b7992a20471a98c4452611b899c962cb1c84e95ba8799ea37bbb$
  roles:
  - user
  - admin
  settings: {}
" > /home/*/.octoprint/users.yaml


#Config Setup
echo "accessControl:
  salt: rXtLZT8e6v2Hs5g3Xc4SoA9n23PLgaQP
api:
  key: 707CF5B1BCAA47F894456030AE30BE66
appearance: {}
feature:
  keyboardControl: false
gcodeViewer:
  enabled: false
plugins:
  cura:
    cura_engine: /usr/share/CuraEngine/build/CuraEngine
  discovery:
    upnpUuid: 42f62915-1f56-4768-b623-009158230c64
  snapstream:
    fps: '1'
    url: http://172.16.80.236:8080/?action=snapshot
  softwareupdate:
    _config_version: 4
    checks:
      octoprint:
        type: github_release
printerParameters: {}
printerProfiles:
  defaultProfile:
    axes:
      e:
        inverted: false
        speed: 300
      x:
        inverted: false
        speed: 6000
      y:
        inverted: false
        speed: 6000
      z:
        inverted: false
        speed: 200
    color: red
    extruder:
      count: 1
      nozzleDiameter: 0.4
      offsets:
      - - 0.0
        - 0.0
    heatedBed: false
    id: _default
    model: Generic RepRap Printer
    name: Default
    volume:
      depth: 200.0
      formFactor: rectangular
      height: 200.0
      origin: lowerleft
      width: 200.0
serial:
  autoconnect: true
  baudrate: 0
  port: AUTO
  timeout: {}
server:
  commands:
    serverRestartCommand: ''
    systemRestartCommand: ''
    systemShutdownCommand: ''
  firstRun: false
  secretKey: grHM0QUheDH360LlzOl3Jcm3mEhhiFlV
slicing:
  defaultProfiles: {}
system:
  actions:
  - action: shutdown
    command: sudo shutdown -h now
    confirm: You are about to shutdown the system.
    name: Shutdown
  - action: reboot
    command: sudo shutdown -r now
    confirm: You are about to reboot the system
    name: Reboot
temperature:
  profiles:
  - bed: 100
    extruder: '270'
    name: Nylon
  - bed: 60
    extruder: '215'
    name: PLA
webcam:
  ffmpeg: /usr/bin/ffmpeg
  snapshot: http://172.16.80.236:8080/?action=snapshot
  stream: http://127.0.0.1:8080/?action=stream
  timelapse:
    fps: 25
    options: {}
    postRoll: 0
    type: zchange
  watermark: false
" > /home/*/.octoprint/config.yaml