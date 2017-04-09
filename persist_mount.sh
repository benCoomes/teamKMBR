#!/bin/bash

#make mount persist on reboot
echo "#SHARED SOFTWARE SETUP" >> /etc/fstab
echo "nfsserv:/software /software nfs" >> /etc/fstab
