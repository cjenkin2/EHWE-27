#!/bin/bash

if [ $# -ne 1 ] #Expects one file - input video file 
then
        echo "Usage: $0 <wpa_configuration_file>"
	echo "Note: use \`wpa_passphrase [ssid] [passphrase] > wpa.conf' to generate"
        exit 65 # bad arguments
fi

#Start the network from the command line
sudo service network-manager stop 
sudo killall -9 wpa_supplicant
sudo wpa_supplicant -B -Dwext -iwlan0 -c $1 -d 
sudo dhclient wlan0

#TODO query for status. Program marches on to tests whether or not
# a network connection is established

#Run network test commands
ping -c 100 google.com &
sudo ping -f genesi-tech.com &
wget -b http://www.ubuntu.com/start-download?distro=desktop&bits=32&release=lts &
