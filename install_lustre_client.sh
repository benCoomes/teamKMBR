#!/bin/bash

sudo cp /users/mdrodge/teamKMBR/master_client.sh /etc/init.d/
update-rc.d master_client.sh defaults
sudo /etc/init.d/master_client.sh
