#!/bin/bash

sudo echo "/users/mdrodge/teamKMBR/master_client.sh" >> /etc/rc.local
sudo chmod +x /etc/rc.local
sudo sed -i '/requiretty/d' /etc/sudoers
sudo /users/mdrodge/teamKMBR/master_client.sh
