"""An example of constructing a profile with two PCs loaded with
CentOS and connected on a LAN. One node downloads and unzips an mpi tarball.

Instructions:
Wait for the profile instance to start, and then log in to the host via the
ssh port specified below.
"""

import geni.portal as portal
import geni.rspec.pg as rspec

# Create a Request object to start building the RSpec.
request = portal.context.makeRequestRSpec()
 
# Create raw PCs with CentOs 6.6 installed
node1 = request.RawPC("node1")
node1.disk_image = "urn:publicid:IDN+emulab.net+image+emulab-ops:CENTOS66-64-STD"

node2 = request.RawPC("node2")
node2.disk_image = "urn:publicid:IDN+emulab.net+image+emulab-ops:CENTOS66-64-STD"

iface1 = node1.addInterface("if1")
iface2 = node2.addInterface("if2")

link = request.LAN("lan")

link.addInterface(iface1)
link.addInterface(iface2)

node1.addService(rspec.Install(
  url="https://www.open-mpi.org/software/ompi/v1.10/downloads/openmpi-1.10.3.tar.gz", 
  path="/local"))
node1.addService(rspec.Execute(shell="bash", command="tar -xvf /local/openmpi-1.10.3.tar.gz"))

# Print the RSpec to the enclosing page.
portal.context.printRequestRSpec()