#!/bin/bash

source ~/.bash_profile

wget https://repo.continuum.io/archive/Anaconda3-4.3.1-Linux-x86_64.sh

bash Anaconda3-4.3.1-Linux-x86_64.sh

pip install --user mpi4py #should we install as user? 
