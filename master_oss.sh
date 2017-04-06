#!/bin/sh

workingpath='/root/teamKMBR/'

if [ -e "$workingpath"config_oss_log.txt ]; then
   # Nothing. Done.
   echo "nothing" > /dev/null
elif [ -e "$workingpath"server_log.txt ]; then
   # server post and config mgs_mdt or oss
   sudo "$workingpath"setup_server_post.sh 2>&1 | tee -a "$workingpath"server_log.txt
   sudo "$workingpath"config_oss.sh 2>&1 | tee -a "$workingpath"config_oss_log.txt
elif [ -e "$workingpath"setup_log.txt ]; then
   # setup post and server pre
   sudo "$workingpath"setup_post.sh 2>&1 | tee -a "$workingpath"setup_log.txt
   sudo "$workingpath"setup_server_pre.sh 2>&1 | tee -a "$workingpath"server_log.txt
else
   # setup pre
   sudo "$workingpath"setup_pre.sh 2>&1 | tee -a "$workingpath"setup_log.txt
fi
