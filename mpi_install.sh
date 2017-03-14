#!/bin/bash

wget https://www.open-mpi.org/software/ompi/v1.10/downloads/openmpi-1.10.3.tar.gz

tar -xvf openmpi-1.10.3.tar.gz 

cd openmpi-1.10.3

sudo ./configure --prefix="/home/$USER/.openmpi"

sudo make install

export PATH="$PATH:/home/$USER/.openmpi/bin"

export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/home/$USER/.openmpi/lib/"

