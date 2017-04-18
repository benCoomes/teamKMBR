#add module load to bashrc
# parameter is username@host 
ssh -t $1 'echo "module load openmpi-1.10.3" >> ~/.bashrc"'
ssh -t $1 'echo "module load anaconda3-4.3.1" >> ~/.bashrc"'
