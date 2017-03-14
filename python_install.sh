#!/bin/bash

source ~/.bash_profile

wget https://repo.continuum.io/archive/Anaconda3-4.3.1-Linux-x86_64.sh

bash Anaconda3-4.3.1-Linux-x86_64.sh -b -p $HOME/anaconda3

NEWPATH = 'PATH=$PATH:/home/$USER/anaconda3/bin'

echo $NEWPATH >> ~/.bash_profile

source ~/.bash_profile

pip install --user mpi4py #should we install as user? 

