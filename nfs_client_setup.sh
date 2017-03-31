yum install nfs-utils nfs-utils-lib

mkdir -p /mnt/nfs/home

#use server ip here
mount 128.104.222.172:/home /mnt/nfs/home

#to check it is mounted, not necessary:
df -h


