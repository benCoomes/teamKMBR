#!/bin/bash
wget https://www.open-mpi.org/software/ompi/v1.10/downloads/openmpi-1.10.3.tar.gz
tar -xvf openmpi-1.10.3.tar.gz 
rm openmpi-1.10.3.tar.gz
cd openmpi-1.10.3
./configure --prefix="/software/openmpi/1.10.3"

make 
make install

echo export PATH="$PATH:/software/openmpi/1.10.3" >> /etc/environment
echo export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/software/openmpi/1.10.3/lib/" >>/etc/environment
