#!/bin/bash

# Client Configuration ( [root@client]$ )
   # Mount the Lustre file system
   mkdir /mnt/lustre
   mount –t lustre mgs_mds@tcp:/lustre /mnt/lustre

   # Create a test file to ensure the system is working
   #touch /mnt/lustre/testFile
   #ls /mnt/lustre
