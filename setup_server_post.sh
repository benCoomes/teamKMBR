#!/bin/bash

   cd /root/teamKMBR

   yum install openmpi net-snmp net-snmp-utils libyaml sg3_utils -y

   # Download Lustre server modules
   # from https://downloads.hpdd.intel.com/public/lustre/lustre-2.7.0/el6.6/server/RPMS/x86_64/
   # download: lustre-2.7.0 lustre-iokit lustre-modules lustre-osd-ldiskfs lustre-osd-ldiskfs-mount lustre-tests
   wget https://downloads.hpdd.intel.com/public/lustre/lustre-2.7.0/el6.6/server/RPMS/x86_64/lustre-2.7.0-2.6.32_504.8.1.el6_lustre.x86_64.x86_64.rpm --no-check-certificate
   wget https://downloads.hpdd.intel.com/public/lustre/lustre-2.7.0/el6.6/server/RPMS/x86_64/lustre-iokit-2.7.0-2.6.32_504.8.1.el6_lustre.x86_64.x86_64.rpm --no-check-certificate
   wget https://downloads.hpdd.intel.com/public/lustre/lustre-2.7.0/el6.6/server/RPMS/x86_64/lustre-modules-2.7.0-2.6.32_504.8.1.el6_lustre.x86_64.x86_64.rpm --no-check-certificate
   wget https://downloads.hpdd.intel.com/public/lustre/lustre-2.7.0/el6.6/server/RPMS/x86_64/lustre-osd-ldiskfs-2.7.0-2.6.32_504.8.1.el6_lustre.x86_64.x86_64.rpm --no-check-certificate
   wget https://downloads.hpdd.intel.com/public/lustre/lustre-2.7.0/el6.6/server/RPMS/x86_64/lustre-osd-ldiskfs-mount-2.7.0-2.6.32_504.8.1.el6_lustre.x86_64.x86_64.rpm --no-check-certificate
   wget https://downloads.hpdd.intel.com/public/lustre/lustre-2.7.0/el6.6/server/RPMS/x86_64/lustre-tests-2.7.0-2.6.32_504.8.1.el6_lustre.x86_64.x86_64.rpm --no-check-certificate

   # Download e2fsprogs
   # from https://downloads.hpdd.intel.com/public/e2fsprogs/latest/el6/RPMS/x86_64
   # download: e2fsprogs-1.42.12.wc1-7.el6.x86_64.rpm e2fsprogs-libs-1.42.12.wc1-7.el6.x86_64.rpm libcom_err-1.42.12.wc1-7.el6.x86_64.rpm libss-1.42.12.wc1-7.el6.x86_64.rpm
   wget https://downloads.hpdd.intel.com/public/e2fsprogs/latest/el6/RPMS/x86_64/e2fsprogs-1.42.13.wc5-7.el6.x86_64.rpm --no-check-certificate
   wget https://downloads.hpdd.intel.com/public/e2fsprogs/latest/el6/RPMS/x86_64/e2fsprogs-libs-1.42.13.wc5-7.el6.x86_64.rpm --no-check-certificate
   wget https://downloads.hpdd.intel.com/public/e2fsprogs/latest/el6/RPMS/x86_64/libcom_err-1.42.13.wc5-7.el6.x86_64.rpm --no-check-certificate
   wget https://downloads.hpdd.intel.com/public/e2fsprogs/latest/el6/RPMS/x86_64/libcom_err-devel-1.42.13.wc5-7.el6.x86_64.rpm --no-check-certificate
   wget https://downloads.hpdd.intel.com/public/e2fsprogs/latest/el6/RPMS/x86_64/libss-1.42.13.wc5-7.el6.x86_64.rpm --no-check-certificate

   # Update / install e2fsprogs and related libraries
   rpm -Uvh e2fsprogs-1.42.13.wc5-7.el6.x86_64.rpm e2fsprogs-libs-1.42.13.wc5-7.el6.x86_64.rpm libcom_err-1.42.13.wc5-7.el6.x86_64.rpm libss-1.42.13.wc5-7.el6.x86_64.rpm libcom_err-devel-1.42.13.wc5-7.el6.x86_64.rpm

   # Install lustre rpms
   rpm -ivh lustre-modules-*
   rpm -ivh lustre-osd-ldiskfs-*
   rpm -ivh lustre-2.7*
   rpm -ivh lustre-iokit-2.7*
   rpm -ivh lustre-tests-*

