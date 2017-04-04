#!/bin/bash

# Install Lustre on Client
   # Download Lustre client kernel RPM
   wget \
   ftp://mirror.switch.ch/pool/4/mirror/scientificlinux/6.3/x86_64/updates/security/kernel-2.6.32-504.8.1.el6.x86_64.rpm
   #http://vault.centos.org/6.6/centosplus/x86_64/Packages/kernel-2.6.32-504.8.1.el6.centos.plus.x86_64.rpm
   #http://mirror.centos.org/centos/6.8/updates/x86_64/Packages/kernel-2.6.32-642.6.2.el6.x86_64.rpm

   # Install the kernel RPM
   rpm -ivh --force kernel-2.6.32-504.8.1.el6.x86_64.rpm

   # Install the kernel
   /sbin/new-kernel-pkg --package kernel --mkinitrd \
   --dracut --depmod --install 2.6.32-504.8.1.el6.x86_64
   
   reboot
