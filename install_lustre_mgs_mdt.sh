#!/bin/bash

sudo cp /users/mdrodge/teamKMBR/master_mgs_mdt.sh /etc/init.d/
update-rc.d master_mgs_mdt.sh defaults
sudo /etc/init.d/master_mgs_mdt.sh
