#!/bin/bash

sudo echo "/root/teamKMBR/master_mgs_mdt.sh" >> /etc/rc.local
sudo chmod +x /etc/rc.local
sudo sed -i '/requiretty/d' /etc/sudoers
sudo /root/teamKMBR/master_mgs_mdt.sh
