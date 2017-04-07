#!/bin/bash

if [ $# -ne 1 ]; then
   echo "ERROR: Need oss index as argument"
   exit 1
fi

sudo echo "/root/teamKMBR/master_oss.sh $1" >> /etc/rc.local
sudo chmod +x /etc/rc.local
sudo sed -i '/requiretty/d' /etc/sudoers
sudo /root/teamKMBR/master_oss.sh $1
