#!/bin/bash

# from lustre.ornl.gov
# NOTE: not ready to run, needs to be partioned to different types of servers

# Prepare servers and client
   # First install minimal CentOS
   # Disable SELinux
   # Set SELINUX=disabled in /etc/sysconfig/selinux
   # Need to do bash magic for this

   # Disable iptables
   chkconfig --levels 345 iptables off
   chkconfig --levels 345 ip6tables off
   reboot # is this even a command on CentOS?

   # Update kernel-firmware
   yum updage kernel-firmware

   # Make sure there's a non-loopback address

   # Create an entry in /etc/modprobe.d/lustre.conf
   options lnet networks=tcp # or networks=tcp(eth0)
   # maybe bash magic again

# Install Lustre on Servers
   # Download Lustre server kernel
   wget https://downloads.hpdd.intel.com/public/lustre/lustre-2.7.0/el6.6/server/RPMS/x86_64/kernel-2.6.32-504.8.1.el6_lustre.x86_64.rpm

   # Install the kernel RPM
   rpm -ivh kernel-2.6.32-504.8.1.el6_lustre.x86_64.rpm

   # Install the kernel
   /sbin/new-kernel-pkg --package kernel --mkinitrd \
   --dracut --depmod \
   --install 2.6.32-504.8.1.el6_lustre.x86_64
   
   reboot

   # Download Lustre server modules
   # from https://downloads.hpdd.intel.com/public/lustre/lustre-2.7.0/el6.6/server/RPMS/x86_64/
   # download: lustre-2.7.0 lustre-iokit lustre-modules lustre-osd-ldiskfs lustre-osd-ldiskfs-mount lustre-tests

   # Download e2fsprogs
   # from https://downloads.hpdd.intel.com/public/e2fsprogs/latest/el6/RPMS/x86_64
   # download: e2fsprogs-1.42.12.wc1-7.el6.x86_64.rpm e2fsprogs-libs-1.42.12.wc1-7.el6.x86_64.rpm libcom_err-1.42.12.wc1-7.el6.x86_64.rpm libss-1.42.12.wc1-7.el6.x86_64.rpm

   # Update / install e2fsprogs and related libraries
   rpm -Uvh e2fsprogs-1.42.12.wc1-7.el6.x86_64.rpm e2fsprogslibs-1.42.12.wc1-7.el6.x86_64.rpm libcom_err-1.42.12.wc1-7.el6.x86_64.rpm libss-1.42.12.wc1-7.el6.x86_64.rpm

   # Install lustre rpms
   rpm -ivh lustre-modules-*
   rpm -ivh lustre-osd-ldiskfs-*
   rpm -ivh lustre-2.7*
   rpm -ivh lustre-iokit-2.7*
   rpm -ivh lustre-tests-*

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

   # Install Lustre client modules
   rpm -ivh lustre-client-modules-2.7.0-2.6.32_504.8.1.el6.x86_64.x86_64.rpm
   rpm -ivh lustre-client-2.7.0-2.6.32_504.8.1.el6.x86_64.x86_64.rpm

# MGS/MDS Configuration / Starting the File System
   # To be copied

# OSS Configuration
   # To be copied

# Client Configuration
   # To be copied

# Multiple File Systems
   # To be copied
