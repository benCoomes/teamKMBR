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

   reboot
