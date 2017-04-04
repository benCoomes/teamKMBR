#!/bin/sh

workingpath='/users/mdrodge/teamKMBR/'

if [ -e "$workingpath"config_mgs_mdt_log.txt ]; then
   # Nothing. Done.
   echo "nothing" > /dev/null
elif [ -e "$workingpath"server_log.txt ]; then
   # server post and config mgs_mdt or oss
   sudo "$workingpath"setup_server_post.sh | tee -a "$workingpath"server_log.txt
   sudo "$workingpath"config_mgs_mdt.sh | tee -a "$workingpath"config_mgs_mdt_log.txt
elif [ -e "$workingpath"setup_log.txt ]; then
   # setup post and server pre
   sudo "$workingpath"setup_post.sh | tee -a "$workingpath"setup_log.txt
   sudo "$workingpath"setup_server_pre.sh | tee -a "$workingpath"server_log.txt
else
   # setup pre
   sudo "$workingpath"setup_pre.sh | tee -a "$workingpath"setup_log.txt
fi
