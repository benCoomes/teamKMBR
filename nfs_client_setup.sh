ssh -t $1 'yum install -y nfs-utils nfs-utils-lib'

ssh -t $1 'mkdir /software'


ssh -t $1 'mount nfsserv:/software /software'

#make mount persist on reboot
ssh -t $1 'echo "#SHARED SOFTWARE SETUP" >> /etc/fstab'
ssh -t $1 'echo "nfsserv:/software /software nfs" >> /etc/fstab'

#to check it is mounted, not necessary:
#df -h


