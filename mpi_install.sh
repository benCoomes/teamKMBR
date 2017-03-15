#!/bin/bash

wget https://www.open-mpi.org/software/ompi/v1.10/downloads/openmpi-1.10.3.tar.gz

tar -xvf openmpi-1.10.3.tar.gz 

cd openmpi-1.10.3

./configure --prefix="/users/$USER/.openmpi"

make install

NEWPATH='PATH=$PATH:/home/$USER/.openmpi/bin'
NEWLD_LIB='LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/users/$USER/.openmpi/lib/'
EXPORT_LDLIB='export LD_LIBRARY_PATH'

echo $NEWPATH >> ~/.bash_profile
echo $NEWLD_LIB >> ~/.bash_profile
echo $EXPORT_LDLIB >> ~/.bash_profile

