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
   # To be copied

# Install Lustre on Client
   # To be copied

# MGS/MDS Configuration / Starting the File System
   # To be copied

# OSS Configuration
   # To be copied

# Client Configuration
   # To be copied

# Multiple File Systems
   # To be copied
