yum install -y nfs-utils nfs-utils-lib

mkdir /software

#use server ip here
mount nfsserv:/software /software

#to check it is mounted, not necessary:
#df -h


