#!/bin/bash

ssh -t $1 'sudo git clone https://github.com/benCoomes/teamKMBR.git /teamKMBR'
ssh -t $1 'sudo chmod 755 /teamKMBR/*install.sh'
echo "Cloned git repo"

echo "Starting mpi install, this may take a few minutes..."
ssh -t $1 'sudo /teamKMBR/mpi_install.sh'
echo "Done.\n"

ssh -t $1 'sudo yum -y environment-modules'
ssh -t $1 'sudo cp /teamKMBR/openmpi-1.10.3 /usr/share/Modules/modulefiles/openmpi-1.10.3' 

echo "Starting python install, this may take a few minutes..."
ssh $1  '/teamKMBR/python_install.sh'
echo "Done. Node successfully configured!" 
echo "(note that node may not be successfully configured)... ;)"
