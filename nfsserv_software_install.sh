#!/bin/bash
# to be run after nfs_serv_setup.sh
# to be run before client_software_config

# get software install scripts and envmodules tarball in repo
echo "Cloning git repo containing set up files..."
ssh -t $1 'sudo git clone https://github.com/benCoomes/teamKMBR.git /teamKMBR'
echo "Done: Cloned git repo"

# install environmentmodules
echo "Installing environment modules"
ssh -t $1 'sudo /teamKMBR/environment_modules_install.sh'
echo "Done: environment modules installed"

# install mpi to /software directory using script
echo "Starting mpi install, this may take a few minutes..."
ssh -t $1 'sudo /teamKMBR/mpi_install.sh'
echo "Done: Mpi installed.\n"

# copy modulefiles to modulefiles directory 
ssh -t $1 'sudo cp /teamKMBR/openmpi-1.10.3 /software/Modules/modulefiles/openmpi-1.10.3' 
ssh -t $1 'sudo cp /teamKMBR/anaconda3-4.3.1 /software/Modules/modulefiles/anaconda3-4.3.1' 

# install anaconda and mpi4py: dependednt on mpi being installed
echo "Starting python install, this may take a few minutes..."
ssh -t $1  'sudo -i /teamKMBR/python_install.sh'
echo "Done: python and mpi4py installed"

