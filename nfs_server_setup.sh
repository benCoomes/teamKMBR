yum install nfs-utils nfs-utils-lib

#startup scripts for nfs server
chkconfig nfs on
service rpcbind start
service nfs start


#Add this line to /etc/exports file
#I believe you repeat this for each client?
#/home 128.104.222.174(rw,sync,no_root_squash,no_subtree_check)

exportfs -a
