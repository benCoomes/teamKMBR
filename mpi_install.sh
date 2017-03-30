#!/bin/bash
wget https://www.open-mpi.org/software/ompi/v1.10/downloads/openmpi-1.10.3.tar.gz
tar -xvf openmpi-1.10.3.tar.gz 
rm openmpi-1.10.3.tar.gz
cd openmpi-1.10.3
./configure --prefix="/software/openmpi/1.10.3"

make 
make install

# is it okay to remove this? 
rm -rf ~/openmpi-1.10.3
rmdir ~/openmpi-1.10.3
#don't need these - path setting is handled by environment-modules
#echo export PATH="$PATH:/software/openmpi/1.10.3/bin" >> /$HOME/.bashrc
#echo export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/software/openmpi/1.10.3/lib/" >>/etc/environment
