# System Design
To emulate the described topology of Trestle, we used a total of 8 nodes. 2 nodes act as the Object Storage Servers (OSS) and each uses their own disk as the Object Storage Targets (OST). 1 node serves as the combined Lustre Metadata Server (MDS) and Management Server (MGS).  Another node is the Lustre Metadata Target (MDT) node. Another node is the NFS node and the other 3 nodes are compute nodes. All of the nodes are connected to a single ethernet switch. 

[topology]: https://github.com/benCoomes/teamKMBR/blob/master/diagrams/cloudlab_topology.JPG "Network Topology"
[diagram]: https://github.com/benCoomes/teamKMBR/blob/master/diagrams/simple_lustre_diagram.png "System Diagram"

System Diagram: ![alt text][diagram]

Network Topology: ![alt text][topology]

# Modeling The Trestle System
We modeled our design after information we retrieved from an Oakridge National Library Introduction to Lustre outline. This can be found at http://lustre.ornl.gov/lustre101-courses/content/C1/L1/LustreIntro.pdf. According to the Oak Ridge International Laboratory's Introduction to Lustre, Lustre is composed of an MDS, MDT, OSS, OST, MGS, and MGT. The Metadata Server (MDS) manages filenames and directories, file stripe locations, locking, and access control lists. The Management Server(MGS) stores configuration for the Lustre file systems. The diagram provided in the documentation shows that the MDS and MGT can be combined so we decided to dedicate one of our nodes to serving as the combined MDS/MGT node. The Object Storage Servers (OSS) handle I/O requests for file data. 2 of our 8 nodes will serve as OSSs. The disks of the these nodes will act as the Object Storage Targets (OST) that are used by the OSS as a block device to store file data. The disk of the MDS/MDS node will act as the Management Server Target (MGT) which is used for data storage by the MGS. We dedicated another node to serve as the Lustre Metadata Target (MDT) node which is a block device used by the MDS to store metadata information. The final three nodes are compute nodes. We have modeled our system after the diagram shown in the link provided above with each of the major system components covered by one or more cloudlab nodes. 

Additionally, our system uses NFS and environmentmodules to provide an easilly configurable software environment. One node is used as an nfs server, and software is installed to its /software directory. Other nodes mount this directory and then use module commands to load different software. 

# Script Summary
The first script set to be run installs essential software and makes it available through a shared Network File System (NFS) directory. nfsserve_software_install.sh is used to download and install environment modules, openmpi and anaconda3 on the nfs server machine. This script relies on the mpi_install.sh, python_install.sh, and environment_modules_install.sh scripts. nfs_server_setup.sh is then run on the nfs server to start serving the shared software directory. nfs_client_setup.sh is then called on each nfs client node to have the client mount the shared software directory on the nfs server.   

The next script set to run intalls Lustre onto the system. The setup process has two phases: a general setup  and a specific setup for each section. The sections are divided into multiple clients, 1 mgs_mdt node, and many OSS. The mgs_mgt and OSS are treated as servers. Then after everything is setup, the system is configured. setup_pre.sh is called followed by setup_post.sh. These scripts setup the general functionality. Then setup_client_pre.sh and setup_server_pre.sh are called followed by setup_client_post.sh and setup_server_post.sh. The config_client.sh, config_mgs_mdt.sh, and config_oss.sh are called and configure each specific part of the system. The user calls install_lustre_client.sh, install_lustre_mgs_mdt.sh, and install_lustre_oss.sh which call master_client.sh, master_mgs_mdt.sh, and master_oss.sh. These master scripts then call all of the setup and configuration scripts mentioned above. The accessed nodes are named client1, client2, client3, oss, mgs_mdt, and client_serv. 
In summary,mpi, python and environment modules, NFS, and lastly Lustre are installed onto the system. 

Finally, users need to be configured to use mpi, which requires paswordless ssh and automatic loading of mpi onto the path. ssh_setup.sh and mpi_user_setup.sh are used to accomplish this for each user. 

The ssh_setup.sh script configures all nodes for passwordless ssh access between each other.  The script must be run from a system that is not one of the cloudlab nodes whose public key is recognized by cloudlab.  The script connects to each node, executes ssh-keygen if keys are not already present, and collects the public keys of all nodes.  The script then appends the list of public keys onto the authorized_keys file of each node.  All nodes can then connect to each other via ssh without password authentication. Usage is as follows: $ ssh_setup.sh username

mpi_user_setup.sh must be run once per user per client node. The usage is as follows: $mpi_user_setup.sh username@nodeaddress. 
This configures the nodes to automatically load open mpi and anaconda by modifying the bashrc. 


[results]: https://github.com/benCoomes/teamKMBR/blob/master/diagrams/log_capture.JPG "Validation Results"
# Validation
To validate our results, we ran Ben's Assignment 4 Part 1 that computed the number of unique jobs in the job_events folder with our Trestle scripts.It successfully computed the number of unique jobs and we logged the output results in jobcount.log:

![alt text][results]

# Sources Used
NFS install and configuration: Tim Brehm, 'Setting Up and NFS Server and Client on CentOS 7.2', on HowToForge website. https://www.howtoforge.com/tutorial/setting-up-an-nfs-server-and-client-on-centos-7/ 

Installing and using Enviornment Modules: Jeff Layton, Environment Modules - A Great Tool for Clusters, Admin Magazine online. http://www.admin-magazine.com/HPC/Articles/Environment-Modules

Custom Install of OpenMPI for a Clutser: Dwaraka Nath, Running an MPI Cluster within a LAN. http://mpitutorial.com/tutorials/running-an-mpi-cluster-within-a-lan/

Use of genilib for automatic Cloudlab profile generation: Cloudlab Documentation: http://docs.cloudlab.us/geni-lib.html

And of course, a copious amount of questions were answered by the Stack Overflow community. 






http://cdn.opensfs.org/wp-content/uploads/2015/04/Lustre-101_Andrus.pdf
