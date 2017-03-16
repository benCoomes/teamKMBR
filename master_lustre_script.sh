#!/bin/bash

# from http://lustre.ornl.gov/lustre101-courses/content/C1/L3/LustreBasicInstall.pdf
# NOTE: not ready to run, needs to be partioned to different types of servers

# Prepare servers and client
   # First install minimal CentOS
   # Disable SELinux
   # Set SELINUX=disabled in /etc/sysconfig/selinux
   if [ ! -e /etc/sysconfig/selinux ]; then
      echo "SELINUX=disabled" > /etc/sysconfig/selinux
   else
      exists='cat /etc/sysconfig/selinux | grep SELINUX'
      if [ exists ]; then
         sed -ie 's/SELINUX=.*$/SELINUX=disabled'
      else
         echo "SELINUX=disabled" >> /etc/sysconfig/selinux
   fi

   # Disable iptables
   chkconfig --levels 345 iptables off
   chkconfig --levels 345 ip6tables off
   reboot # Gotta make sure the script keeps going

   # Update kernel-firmware
   yum updage kernel-firmware

   # Make sure there's a non-loopback address

   # Create an entry in /etc/modprobe.d/lustre.conf
   #options lnet networks=tcp # or networks=tcp(eth0)
   if [ ! -e /etc/modprobe.d/lustre.conf ]; then
      echo "options lnet networks=tcp" > /etc/modprobe.d/lustre.conf
   else
      exists='cat /etc/sysconfig/selinux | grep options lnet networks'
      if [ exists ]; then
         sed -ie 's/options lnet networks.*$/options lnet networks=tcp'
      else
         echo "options lnet networks=tcp" >> /etc/modprobe.d/lustre.conf
   fi


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
   wget https://downloads.hpdd.intel.com/public/lustre/lustre-2.7.0/el6.6/server/RPMS/x86_64/lustre-2.7.0-2.6.32_504.8.1.el6_lustre.x86_64.x86_64.rpm
   wget https://downloads.hpdd.intel.com/public/lustre/lustre-2.7.0/el6.6/server/RPMS/x86_64/lustre-iokit-2.7.0-2.6.32_504.8.1.el6_lustre.x86_64.x86_64.rpm
   wget https://downloads.hpdd.intel.com/public/lustre/lustre-2.7.0/el6.6/server/RPMS/x86_64/lustre-modules-2.7.0-2.6.32_504.8.1.el6_lustre.x86_64.x86_64.rpm
   wget https://downloads.hpdd.intel.com/public/lustre/lustre-2.7.0/el6.6/server/RPMS/x86_64/lustre-osd-ldiskfs-2.7.0-2.6.32_504.8.1.el6_lustre.x86_64.x86_64.rpm
   wget https://downloads.hpdd.intel.com/public/lustre/lustre-2.7.0/el6.6/server/RPMS/x86_64/lustre-osd-ldiskfs-mount-2.7.0-2.6.32_504.8.1.el6_lustre.x86_64.x86_64.rpm
   wget https://downloads.hpdd.intel.com/public/lustre/lustre-2.7.0/el6.6/server/RPMS/x86_64/lustre-tests-2.7.0-2.6.32_504.8.1.el6_lustre.x86_64.x86_64.rpm

   # Download e2fsprogs
   # from https://downloads.hpdd.intel.com/public/e2fsprogs/latest/el6/RPMS/x86_64
   # download: e2fsprogs-1.42.12.wc1-7.el6.x86_64.rpm e2fsprogs-libs-1.42.12.wc1-7.el6.x86_64.rpm libcom_err-1.42.12.wc1-7.el6.x86_64.rpm libss-1.42.12.wc1-7.el6.x86_64.rpm
   wget https://downloads.hpdd.intel.com/public/e2fsprogs/latest/el6/RPMS/x86_64/e2fsprogs-1.42.13.wc5-7.el6.x86_64.rpm
   wget https://downloads.hpdd.intel.com/public/e2fsprogs/latest/el6/RPMS/x86_64/e2fsprogs-libs-1.42.13.wc5-7.el6.x86_64.rpm
   wget https://downloads.hpdd.intel.com/public/e2fsprogs/latest/el6/RPMS/x86_64/libcom_err-1.42.13.wc5-7.el6.x86_64.rpm
   wget https://downloads.hpdd.intel.com/public/e2fsprogs/latest/el6/RPMS/x86_64/libss-1.42.13.wc5-7.el6.x86_64.rpm

   # Update / install e2fsprogs and related libraries
   rpm -Uvh e2fsprogs-1.42.13.wc5-7.el6.x86_64.rpm e2fsprogslibs-1.42.13.wc5-7.el6.x86_64.rpm libcom_err-1.42.13.wc5-7.el6.x86_64.rpm libss-1.42.13.wc5-7.el6.x86_64.rpm

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
   wget https://downloads.hpdd.intel.com/public/lustre/lustre-2.7.0/el6.6/client/RPMS/x86_64/lustre-client-modules-2.7.0-2.6.32_504.8.1.el6.x86_64.x86_64.rpm
   wget https://downloads.hpdd.intel.com/public/lustre/lustre-2.7.0/el6.6/client/RPMS/x86_64/lustre-client-2.7.0-2.6.32_504.8.1.el6.x86_64.x86_64.rpm

   # Install Lustre client modules
   rpm -ivh lustre-client-modules-2.7.0-2.6.32_504.8.1.el6.x86_64.x86_64.rpm
   rpm -ivh lustre-client-2.7.0-2.6.32_504.8.1.el6.x86_64.x86_64.rpm

# MGS/MDS Configuration / Starting the File System ( [root@mgs_mds]$ )
   # Format the MGT
   mkfs.lustre --mgs /dev/sdb

   # Format the MDT
   mkfs.lustre --fsname=lustre \
   --mgsnode=mgs_mds@tcp --mdt --index=0 /dev/sdc
   
   # Mount the MGT
   mkdir /mnt/mgt
   mount –t lustre /dev/sdb /mnt/mgt
   
   # Mount the MDT
   mkdir /mnt/mdt
   mount –t lustre /dev/sdc /mnt/mdt

# OSS Configuration ( [root@oss]$ )
   # Format the OSTs on the OSS
   mkfs.lustre --fsname=lustre --ost \
   --mgsnode=mgs_mds@tcp --index=0 /dev/sdb

   # Mount the OSTs
   mkdir /mnt/ost0 /mnt/ost1
   mount –t lustre /dev/sdb /mnt/ost0
   mount –t lustre /dev/sdc /mnt/ost1

# Client Configuration ( [root@client]$ )
   # Mount the Lustre file system
   mkdir /mnt/lustre
   mount –t lustre mgs_mds@tcp:/lustre /mnt/lustre

   # Create a test file to ensure the system is working
   touch /mnt/lustre/testFile
   ls /mnt/lustre

# Multiple File Systems
   # Do we need this?
