#!/bin/bash

echo "Installing pip"
apt update
apt install net-tools vim -y 

echo "ping client"
su --login -c "ping 192.168.56.2 -c 4" vagrant