#!/bin/bash

sudo service network-manager stop 
sudo killall -9 wpa_supplicant
sudo wpa_supplicant -B -Dwext -iwlan0 -c wpa.conf -d 
sudo dhclient wlan0
