#!/bin/bash

echo "generate keys"
ssh-keygen -t ecdsa -b 521 -f ~/.ssh/vagrantkey -q -N ""

#echo "configuring remote access via API"
#lxc config set core.https_address 192.168.56.2:8443

#yes | ssh -o StrictHostKeyChecking=no remoto@192.168.56.2

#echo "copy keys"
#yes |ssh-copy-id -p 2222 -o StrictHostKeyChecking=no -i vagrantkey remoto@192.168.56.2

#echo "prueba SCP" >> test.txt

#echo "uploading file"
#scp -P 2222 test.txt remoto@192.168.56.2:/~
