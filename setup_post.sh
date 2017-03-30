#!/bin/bash

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

