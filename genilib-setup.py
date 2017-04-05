"""This constructs 7 nodes connected on a lan to simulate an hpc cluster. 

Instructions:
Wait for the profile instance to start, and then log in to the host via the
ssh port specified below.
"""

import geni.portal as portal
import geni.rspec.pg as rspec

# Create a Request object to start building the RSpec.
request = portal.context.makeRequestRSpec()
nodeNames = ["client1", "client2", "client3", 
         "nfsserv", "oss1", "oss2", "mgs_mdt"]
ifaces = {}

for name in nodeNames:
   nodeobj = request.RawPC(name)
   nodeobj.disk_image = "urn:publicid:IDN+emulab.net+image+emulab-ops:CENTOS66-64-STD"
   ifacename = name + "_iface"
   ifaceobj = nodeobj.addInterface(ifacename)
   ifaces[ifacename] = ifaceobj

link = request.LAN("lan")
for interface in ifaces:
   link.addInterface(ifaces[interface])

# Print the RSpec to the enclosing page.
portal.context.printRequestRSpec()
