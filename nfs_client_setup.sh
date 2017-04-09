ssh -t $1 'sudo yum install -y nfs-utils nfs-utils-lib'
ssh -t $1 'sudo yum install -y tcl'

echo "Mounting shared software directory"
ssh -t $1 'sudo mkdir /software'
ssh -t $1 'sudo mount nfsserv:/software /software'

echo "Configuring environment modules"
ssh -t $1 'sudo cp /software/Modules/init/sh /etc/profile.d/modules.sh'
ssh -t $1 'module use /software/Modules/modulefiles'

echo "Done. Node configured for shared software use."
#make mount persist on reboot
ssh -t $1 'sudo git clone https://github.com/benCoomes/teamKMBR.git /teamKMBR'
ssh -t $1 'sudo /teamKMBR/persist_mount.sh'

#to check it is mounted, not necessary:
#df -h


