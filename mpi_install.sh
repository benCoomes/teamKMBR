#!/bin/bash

wget https://www.open-mpi.org/software/ompi/v1.10/downloads/openmpi-1.10.3.tar.gz

tar -xvf openmpi-1.10.3.tar.gz 

cd openmpi-1.10.3

./configure --prefix="/software/openmpi/1.10.3"

# below should be run as root
#############################
make 
make install

NEWPATH='PATH=$PATH:/home/$USER/.openmpi/bin'
NEWLD_LIB='LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/users/$USER/.openmpi/lib/'
EXPORT_LDLIB='export LD_LIBRARY_PATH'

echo $NEWPATH >> /etc/environment
echo $NEWLD_LIB >> /etc/environment
source /etc/environment
############################
#above should be run as root

echo "INSTALL VERIFICATION"
printenv PATH
which mpicc
