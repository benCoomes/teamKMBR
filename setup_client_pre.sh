#!/bin/bash

# Install Lustre on Client
   # Download Lustre client kernel RPM
   wget \
   http://mirror.centos.org/centos/6.6/updates/x86_64/Packages/kernel-2.6.32-504.8.1.el6.x86_64.rpm

   # Install the kernel RPM
   rpm -ivh kernel-2.6.32-504.8.1.el6.x86_64.rpm

   # Install the kernel
   /sbin/new-kernel-pkg --package kernel --mkinitrd \
   --dracut --depmod --install 2.6.32-504.8.1.el6.x86_64
   
   reboot
