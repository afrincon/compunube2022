sudo apt update
sudo apt install lxd -y

newgrp lxd
sudo lxd init --auto
lxc launch ubuntu:20.04 u1
lxc list
lxc info u1
lxc config show u1
lxc exec u1 -- free -m
lxc config set u1 limits.memory 64MB
lxc exec u1 -- apt-get install net-tools -y

