#!/bin/bash

echo "Installing pip"
apt update
apt install python3-pip net-tools vim -y 

echo "updating pip"
su --login -c "python3 -m pip install --upgrade pip" vagrant
echo "install Jupyter Notebook"
su --login -c "pip3 install notebook" vagrant
echo "update version of markupsafe"
su --login -c "pip3 install markupsafe==2.0.1" vagrant

echo "export vars"
su --login -c "export PATH='$HOME/.local/bin:$PATH'" vagrant

echo "run jupyter"
su --login -c "nohup jupyter notebook --ip=0.0.0.0 --notebook-dir='/notebooks' &" vagrant
echo "display"
su --login -c "jupyter notebook list" vagrant
