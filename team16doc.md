# System Design
To emulate the described topology of Trestle, we used a total of 8 nodes. 2 nodes act as the Object Storage Servers (OSS) and each uses their own disk as the Object Storage Targets (OST). 1 node serves as the combined Lustre Metadata Server (MDS) and Management Server (MGS).  Another node is the Lustre Metadata Target (MDT) node. Another node is the NFS node and the other 3 nodes are compute nodes. All of the nodes are connected to a single ethernet switch. 

[topology]: https://github.com/benCoomes/teamKMBR/blob/master/diagrams/cloudlab_topology.JPG "Network Topology"
[diagram]: https://github.com/benCoomes/teamKMBR/blob/master/diagrams/simple_lustre_diagram.png "System Diagram"

System Diagram: ![alt text][diagram]

Network Topology: ![alt text][topology]

# Modeling The Trestle System
We modeled our design after information we retrieved from an Oakridge National Library Introduction to Lustre outline. This can be found at http://lustre.ornl.gov/lustre101-courses/content/C1/L1/LustreIntro.pdf. According to the Oak Ridge International Laboratory's Introduction to Lustre, Lustre is composed of an MDS, MDT, OSS, OST, MGS, and MGT. The Metadata Server (MDS) manages filenames and directories, file stripe locations, locking, and access control lists. The Management Server(MGS) stores configuration for the Lustre file systems. The diagram provided in the documentation shows that the MDS and MGT can be combined so we decided to dedicate one of our nodes to serving as the combined MDS/MGT node. The Object Storage Servers (OSS) handle I/O requests for file data. 2 of our 8 nodes will serve as OSSs. The disks of the these nodes will act as the Object Storage Targets (OST) that are used by the OSS as a block device to store file data. The disk of the MDS/MDS node will act as the Management Server Target (MGT) which is used for data storage by the MGS. We dedicated another node to serve as the Lustre Metadata Target (MDT) node which is a block device used by the MDS to store metadata information. The final three nodes are compute nodes. We have modeled our system after the diagram shown in the link provided above with each of the major system components covered by one or more cloudlab nodes. 

# Script Summary
The first script set to be installs the Network File System (NFS). nfs_client_setup.sh, nfs_client_setup._mod.sh are callled and setup the NFS client and installs the client modules. Then nfs_server_setup.sh and nfs_setup_mod.sh are called to setup the NFS server and install the server modules. After nfs_server_setup is called, then nfsserv_software_install.sh  which installs mpi, python, and sets up the environment modules with environment_modules_install.sh. Then nfsserv_config.sh is called to configure the server. 

The final script set to run intalls Lustre onto the system. The setup process has two phases: a general setup  and a specific setup for each section. The sections are divided into multiple clients, 1 mgs_mdt node, and many OSS. The mgs_mgt and OSS are treated as servers. Then after everything is setup, the system is configured. setup_pre.sh is called followed by setup_post.sh. These scripts setup the general functionality. Then setup_client_pre.sh and setup_server_pre.sh are called followed by setup_client_post.sh and setup_server_post.sh. The config_client.sh, config_mgs_mdt.sh, and config_oss.sh are called and configure each specific part of the system. The user calls install_lustre_client.sh, install_lustre_mgs_mdt.sh, and install_lustre_oss.sh which call master_client.sh, master_mgs_mdt.sh, and master_oss.sh. These master scripts then call all of the setup and configuration scripts mentioned above. The accessed nodes are named client1, client2, client3, oss, mgs_mdt, and client_serv. 
In summary, we install NFS, then mpi, python and the environment modules, and lastly Lustre is installed onto the system. 

# Validation







http://cdn.opensfs.org/wp-content/uploads/2015/04/Lustre-101_Andrus.pdf