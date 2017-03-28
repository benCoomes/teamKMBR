#!/bin/bash

   # Update kernel-firmware
   echo "----- Update kernel-firmware -----"
   yum update kernel-firmware -y
   yum install dracut-kernel -y

   # Make sure there's a non-loopback address

   # Create an entry in /etc/modprobe.d/lustre.conf
   #options lnet networks=tcp # or networks=tcp(eth0)
   echo "----- Create an entry in /etc/modprobe.d/lustre.conf -----"
   if [ ! -e /etc/modprobe.d/lustre.conf ]; then
      echo "options lnet networks=tcp" > /etc/modprobe.d/lustre.conf
   else
      exists='cat /etc/sysconfig/selinux | grep options lnet networks'
      if [ exists ]; then
         sed -ie 's/options lnet networks.*$/options lnet networks=tcp/' /etc/modprobe.d/lustre.conf
      else
         echo "options lnet networks=tcp" >> /etc/modprobe.d/lustre.conf
      fi
   fi

# Install Lustre on Client
   # Download Lustre client kernel RPM
   echo "----- Download Lustre client kernel RPM -----"
   wget \
   http://mirror.centos.org/centos/6.8/updates/x86_64/Packages/kernel-2.6.32-642.6.2.el6.x86_64.rpm

   # Install the kernel RPM
   echo "----- Install the kernel RPM -----"
   rpm -ivh kernel-2.6.32-642.6.2.el6.x86_64.rpm

   # Install the kernel
   echo "----- Install the kernel -----"
   /sbin/new-kernel-pkg --package kernel --mkinitrd \
   --dracut --depmod --install 2.6.32-642.6.2.el6.x86_64

   #reboot
