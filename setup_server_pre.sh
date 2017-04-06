#!/bin/bash

   cd /root/teamKMBR

# Install Lustre on Servers
   # Download Lustre server kernel
   wget https://downloads.hpdd.intel.com/public/lustre/lustre-2.7.0/el6.6/server/RPMS/x86_64/kernel-2.6.32-504.8.1.el6_lustre.x86_64.rpm --no-check-certificate

   # Install the kernel RPM
   rpm -ivh kernel-2.6.32-504.8.1.el6_lustre.x86_64.rpm

   # Install the kernel
   /sbin/new-kernel-pkg --package kernel --mkinitrd \
   --dracut --depmod \
   --install 2.6.32-504.8.1.el6_lustre.x86_64
   
   reboot

