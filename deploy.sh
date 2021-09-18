#!/bin/bash
set -e

helpFunction()
{
   echo ""
   echo "Usage: bash $0 -a remote_server_ip -b port -c username -d password -e worker -f pool -g wallet"
   echo -e "\t-a Remote server IP"
   echo -e "\t-b Connection Port"
   echo -e "\t-c Username"
   echo -e "\t-d Password"
   echo -e "\t-e Worker name"
   echo -e "\t-f Pool to mine with port: eth.2miners.com:2020"
   echo -e "\t-g Wallet id"
   exit 1 # Exit script after printing help
}

while getopts "a:b:c:d:e:f:g:" opt
do
   case "$opt" in
      a ) remote_server_ip="$OPTARG" ;;
      b ) port="$OPTARG" ;;
      c ) username="$OPTARG" ;;
      d ) password="$OPTARG" ;;
      e ) worker="$OPTARG" ;;
      f ) pool="$OPTARG" ;;
      g ) wallet="$OPTARG" ;;
      ? ) helpFunction ;; # Print helpFunction in case parameter is non-existent
   esac
done

# Print helpFunction in case parameters are empty
if [ -z "$remote_server_ip" ] || [ -z "$port" ] || [ -z "$username" ] || [ -z "$password" ] || [ -z "$worker" ] || [ -z "$pool" ] || [ -z "$wallet" ] 
then
   echo "Some or all of the parameters are empty";
   helpFunction
fi

# Begin script in case all parameters are correct
echo "--------- DEPLOY START ---------"
echo "GENERATING CONNECTION TO REMOTE SERVER ..."
sshpass -p $password ssh -o 'StrictHostKeyChecking=no' $username@$remote_server_ip -p $port "exit"
echo "CONNECTION ESTABLISHED - DOWNLOADING MINER ..."
#sshpass -p $password ssh -o 'StrictHostKeyChecking=no' $username@$remote_server_ip -p $port "sudo apt install git && rm -rf miner && git clone https://github.com/ducanhprg/ts-miner-deploy.git miner"
echo "RUNNING MINER ..."
sshpass -p $password ssh -o 'StrictHostKeyChecking=no' $username@$remote_server_ip -p $port "cd miner & bash run_miner.sh -a $pool -b $wallet -c $worker"

echo "--------- DEPLOY COMPLETED ---------"
