yum install -y nfs-utils nfs-utils-lib

mkdir /software


mount nfsserv:/software /software

#make mount persist on reboot
echo "#SHARED SOFTWARE SETUP" >> /etc/fstab
echo "nfsserv:/software /software nfs" >> /etc/fstab

#to check it is mounted, not necessary:
#df -h


