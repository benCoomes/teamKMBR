

declare -a addrs=('rbecwar@clnode015.clemson.cloudlab.us' 'rbecwar@clnode002.clemson.cloudlab.us')
#declare -a keys=()

#for every address in the array, generate an ssh key if it does not exist, concatenate the public key onto a local file
for i in "${addrs[@]}"
do
  if [ ! -f ~/.ssh/id_rsa.pub ]; then
    ssh -t $i 'ssh-keygen -f ~/.ssh/id_rsa -t rsa -N ""'
  fi
  #keys=("${keys[@]}" "$(ssh -t $i 'cat ~/.ssh/id_rsa.pub')")
  ssh -t $i 'cat ~/.ssh/id_rsa.pub' >> pubkeys.txt
done

#append the public keys list to the authorized_keys file of each remote address
for i in "${addrs[@]}"
do
  cat pubkeys.txt| ssh $i 'cat >> ~/.ssh/authorized_keys'
done

#for i in "${keys[@]}"
#do
#  echo $i
#done

rm pubkeys.txt

