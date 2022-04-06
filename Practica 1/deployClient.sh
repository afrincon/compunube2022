#!/bin/bash

echo "Installing pip"
apt udpate
apt install net-tools vim -y 

echo "ping client"
su --login -c "ping 192.168.56.2 -c 4"