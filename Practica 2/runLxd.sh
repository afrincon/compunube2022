#!/bin/bash

newgrp lxd
echo "lxd init #######"
lxd init --auto
echo "creating server ######"
lxc launch -e ubuntu:20.04 server

echo "installing apache2 #######"
lxc exec server -- apt install apache2 -y

echo "<!DOCTYPE html>
<html>
<body>
<h1>Pagina de prueba</h1>
<p>Especializacion IA - Compunube 2022-01</p>
</body>
</html>" >> index.html

lxc file push index.html server/var/www/html/index.html

lxc exec server -- systemctl restart apache2
echo "port forwarding http"
lxc config device add server webport80 proxy listen=tcp:192.168.56.2:5080 connect=tcp:127.0.0.1:80

echo "Changing ssh password parameter"
lxc exec server -- sed -i "/^[^#]*PasswordAuthentication[[:space:]]no/c\PasswordAuthentication yes" /etc/ssh/sshd_config

echo "restarting sshd"
lxc exec server -- systemctl restart sshd
echo "adding new user"
lxc exec server -- useradd remoto -m -s /bin/bash -p remoto

echo "port forwarding sshd"
lxc config device add server sshport22 proxy listen=tcp:192.168.56.2:2022 connect=tcp:127.0.0.1:22

