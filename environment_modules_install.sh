#!/bin/bash
yum install -y tcl
mkdir /software/Modules
mkdir /software/Modules/src
cp /teamKMBR/modules-tcl-1.77.tar.gz /software/Modules/src
cd /software/Modules/src
gunzip -c modules-tcl-1.775.tar.gz | tar xvf -
cd modules-tcl-1.775
./configure  --prefix=/software/Modules \
             --modulefilesdir=/software/Modules/modulefiles
make
make install

# do these for all systems using modules
cp -f init/sh /etc/profile.d/modules.sh
chmod 755 /etc/profile.d/modules.sh
#then add below to .bashrc for each user
#/etc/profile.d/modules.sh
