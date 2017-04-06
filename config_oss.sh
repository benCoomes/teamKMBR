#!/bin/bash

# OSS Configuration ( [root@oss]$ )
   # Format the OSTs on the OSS
   mkfs.lustre --fsname=lustre --ost \
   --mgsnode=mgs_mdt@tcp --index=0 /dev/sdb
   #--mgsnode=128.104.222.29@tcp --index=0 /dev/sdb

   # Mount the OSTs
   mkdir /mnt/ost0
   #mount –t lustre /dev/sdb /mnt/ost0
   sudo mount -t lustre /dev/sdb /mnt/ost0
