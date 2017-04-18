#usage: ./ssh_setup.sh <username>

if [ $# -eq 0 ]
  then
    echo "usage: ./ssh_setup.sh <username>"
    exit 1
fi

declare -a addrs=('clnode011.clemson.cloudlab.us' 'clnode015.clemson.cloudlab.us' 'clnode002.clemson.cloudlab.us' 'clnode006.clemson.cloudlab.us' 'clnode031.clemson.cloudlab.us' 'clnode025.clemson.cloudlab.us' 'clnode029.clemson.cloudlab.us')

#for every address in the array, generate an ssh key if it does not exist, concatenate the public key onto a local file
for i in "${addrs[@]}"
do
  ssh $1@$i "test -e ~/.ssh/id_rsa.pub"
  if [ ! $? -eq 0 ]; then
    ssh -t $1@$i 'ssh-keygen -f ~/.ssh/id_rsa -t rsa -N ""'
  fi
  ssh -t $1@$i 'cat ~/.ssh/id_rsa.pub' >> pubkeys.txt
done

#append the public keys list to the authorized_keys file of each remote address
for i in "${addrs[@]}"
do
  cat pubkeys.txt| ssh $1@$i 'cat >> ~/.ssh/authorized_keys'
done

rm pubkeys.txt

