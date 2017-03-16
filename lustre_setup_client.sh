#!/bin/bash

# from http://lustre.ornl.gov/lustre101-courses/content/C1/L3/LustreBasicInstall.pdf

# Prepare servers and client
   # First install minimal CentOS
   # Disable SELinux
   # Set SELINUX=disabled in /etc/sysconfig/selinux
   if [ ! -e /etc/sysconfig/selinux ]; then
      echo "SELINUX=disabled" > /etc/sysconfig/selinux
   else
      exists='cat /etc/sysconfig/selinux | grep SELINUX'
      if [ exists ]; then
         sed -ie 's/SELINUX=.*$/SELINUX=disabled/' /etc/sysconfig/selinux
      else
         echo "SELINUX=disabled" >> /etc/sysconfig/selinux
      fi
   fi

   # Disable iptables
   chkconfig --levels 345 iptables off
   chkconfig --levels 345 ip6tables off
   reboot # Gotta make sure the script keeps going

   # Update kernel-firmware
   yum update kernel-firmware

   # Make sure there's a non-loopback address

   # Create an entry in /etc/modprobe.d/lustre.conf
   #options lnet networks=tcp # or networks=tcp(eth0)
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
   wget \
   http://mirror.centos.org/centos/6.6/updates/x86_64/Packages/kernel-2.6.32-504.8.1.el6.x86_64.rpm

   # Install the kernel RPM
   rpm -ivh kernel-2.6.32-504.8.1.el6.x86_64.rpm

   # Install the kernel
   /sbin/new-kernel-pkg --package kernel --mkinitrd \
   --dracut --depmod --install 2.6.32-504.8.1.el6.x86_64
   
   reboot

   # Download Lustre client modules
   # from https://downloads.hpdd.intel.com/public/lustre/lustre-2.7.0/el6.6/client/RPMS/x86_64/
   # download: lustre-client-modules lustre-client
   wget https://downloads.hpdd.intel.com/public/lustre/lustre-2.7.0/el6.6/client/RPMS/x86_64/lustre-client-modules-2.7.0-2.6.32_504.8.1.el6.x86_64.x86_64.rpm
   wget https://downloads.hpdd.intel.com/public/lustre/lustre-2.7.0/el6.6/client/RPMS/x86_64/lustre-client-2.7.0-2.6.32_504.8.1.el6.x86_64.x86_64.rpm

   # Install Lustre client modules
   rpm -ivh lustre-client-modules-2.7.0-2.6.32_504.8.1.el6.x86_64.x86_64.rpm
   rpm -ivh lustre-client-2.7.0-2.6.32_504.8.1.el6.x86_64.x86_64.rpm

# Client Configuration ( [root@client]$ )
   # Mount the Lustre file system
   mkdir /mnt/lustre
   mount –t lustre mgs_mds@tcp:/lustre /mnt/lustre

   # Create a test file to ensure the system is working
   #touch /mnt/lustre/testFile
   #ls /mnt/lustre
