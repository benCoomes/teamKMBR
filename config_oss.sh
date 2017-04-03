#!/bin/bash

# OSS Configuration ( [root@oss]$ )
   # Format the OSTs on the OSS
   mkfs.lustre --fsname=lustre --ost \
   --mgsnode=mgs_mds@tcp --index=0 /dev/sdb

   # Mount the OSTs
   mkdir /mnt/ost0 /mnt/ost1
   mount –t lustre /dev/sdb /mnt/ost0
   mount –t lustre /dev/sdc /mnt/ost1
