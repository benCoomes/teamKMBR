#!/bin/bash

sudo cp /users/mdrodge/teamKMBR/master_oss.sh /etc/init.d/
update-rc.d master_oss.sh defaults
sudo /etc/init.d/master_oss.sh
