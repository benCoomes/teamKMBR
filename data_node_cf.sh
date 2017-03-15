#!/bin/bash

ssh $1 'git clone https://github.com/benCoomes/teamKMBR.git ~/teamKMBR'
ssh $1 'chmod 755 ~/teamKMBR/*install.sh'
echo "Cloned git repo"

echo "Starting mpi install, this may take a few minutes..."
ssh -t $1 'sudo ~/teamKMBR/yum_mpi_install.sh'
echo "Done.\n"

echo "Starting python install, this may take a few minutes..."
ssh $1  '~/teamKMBR/python_install.sh'
echo "Done. Node successfully configured!" 
echo "(note that node may not be successfully configured)... ;)"
