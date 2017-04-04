#!/bin/bash

# MGS/MDS Configuration / Starting the File System ( [root@mgs_mds]$ )
   # Format the MGT
   mkfs.lustre --mgs /dev/sdb

   # Format the MDT
   mkfs.lustre --fsname=lustre \
   --mgsnode=128.104.222.29@tcp --mdt --index=0 /dev/sdc
   
   # Mount the MGT
   mkdir /mnt/mgt
   mount –t lustre /dev/sdb /mnt/mgt
   
   # Mount the MDT
   mkdir /mnt/mdt
   mount –t lustre /dev/sdc /mnt/mdt
