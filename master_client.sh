#!/bin/sh

workingpath='/root/teamKMBR/'

if [ -e "$workingpath"config_client_log.txt ]; then
   # Nothing. Done.
   echo "nothing" > /dev/null
elif [ -e "$workingpath"client_log.txt ]; then
   # server post and config mgs_mdt or oss
   sudo "$workingpath"setup_client_post.sh | tee -a "$workingpath"client_log.txt
   sudo "$workingpath"config_client.sh | tee -a "$workingpath"config_client_log.txt
elif [ -e "$workingpath"setup_log.txt ]; then
   # setup post and server pre
   sudo "$workingpath"setup_post.sh | tee -a "$workingpath"setup_log.txt
   sudo "$workingpath"setup_client_pre.sh | tee -a "$workingpath"client_log.txt
else
   # setup pre
   sudo "$workingpath"setup_pre.sh | tee -a "$workingpath"setup_log.txt
fi
