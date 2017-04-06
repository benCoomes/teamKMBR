#!/bin/bash

# Client Configuration ( [root@client]$ )
   # Mount the Lustre file system
   mkdir /mnt/lustre
   #mount –t lustre 128.104.222.29@tcp:/lustre /mnt/lustre
   sudo mount -t lustre mgs_mdt@tcp:lustre /mnt/lustre

   # Create a test file to ensure the system is working
   #touch /mnt/lustre/testFile
   #ls /mnt/lustre
