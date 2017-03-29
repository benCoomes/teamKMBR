#!/bin/bash

module load openmpi-1.10.3

wget https://repo.continuum.io/archive/Anaconda3-4.3.1-Linux-x86_64.sh

bash Anaconda3-4.3.1-Linux-x86_64.sh -b -p /software/anaconda3


module load anaconda3-4.3.1
#NEWPATH='PATH=$PATH:/users/$USER/anaconda3/bin'

#echo $NEWPATH >> ~/.bash_profile

#source ~/.bash_profile

pip install --user mpi4py #should we install as user? 

