newgrp lxd
lxd init --auto

lxc config set core.https_address 192.168.56.3:8443
lxc config set core.trust_password compunube

sudo ufw allow from 192.168.56.2 to 192.168.56.3 port 8443

lxc snapshot webserver
lxc copy webserver/snap0 server1:webserver  --verbose
lxc list server2:


yes |lxc remote add server2 192.168.1.6

