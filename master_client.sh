#!/bin/sh

workingpath='/users/mdrodge/teamKMBR/'

if [ -e "$workingpath"config_client_log.txt ]; then
   # Nothing. Done.
   echo "finished"
elif [ -e "$workingpath"server_log.txt ]; then
   # server post and config mgs_mdt or oss
   sudo $workingpath/setup_server_post.sh | tee -a server_log.txt
   sudo $workingpath/config_client.sh | tee -a config_client.txt
elif [ -e "$workingpath"setup_log.txt ]; then
   # setup post and server pre
   sudo $workingpath/setup_post.sh | tee -a setup_log.txt
   sudo $workingpath/setup_server_pre.sh | tee -a server_log.txt
else
   # setup pre
   sudo $workingpath/setup_pre.sh | tee -a setup_log.txt
fi
