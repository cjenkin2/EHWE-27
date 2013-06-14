#!/bin/bash

sudo service network-manager stop
sudo killall -9 wpa_supplicant
sudo wpa_supplicant -Dwext -iwlan0 -c wpa.conf -d &> ./network_test.log &
sudo dhclient wlan0
