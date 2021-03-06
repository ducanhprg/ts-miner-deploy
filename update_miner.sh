#!/bin/bash
set -e

helpFunction()
{
   echo ""
   echo "Usage: bash $0 -a source_miner_url"
   echo -e "\tExample: https://github.com/trexminer/T-Rex/releases/download/0.21.6/t-rex-0.21.6-linux.tar.gz"
   exit 1 # Exit script after printing help
}

while getopts "a:" opt
do
   case "$opt" in
      a ) source_miner_url="$OPTARG" ;;
      ? ) helpFunction ;; # Print helpFunction in case parameter is non-existent
   esac
done

# Print helpFunction in case parameters are empty
if [ -z "$source_miner_url" ]
then
   echo "Some or all of the parameters are empty";
   helpFunction
fi

# Begin script in case all parameters are correct
echo "--------- BEGIN UPDATING PROCESS ---------"
echo "Removing current miner..."
rm -rf /ts-miner-deploy/t-rex

echo "Getting new source miner..."

wget -O /ts-miner-deploy/tmp.tar.gz $source_miner_url

echo "Creating tmp folder..."
mkdir /ts-miner-deploy/tmp

echo "Extracting source miner..."
tar -xf /ts-miner-deploy/tmp.tar.gz --directory /ts-miner-deploy/tmp

echo "Copying source miner to root..."
cp /ts-miner-deploy/tmp/t-rex .

echo "Cleaning...."
rm -rf /ts-miner-deploy/tmp*
ls -la 

echo "Pushing change to repository...."
cd /ts-miner-deploy/
git add --all
git commit -m "Updating source miner"
git push

echo "------------- UPDATING DONE ------------"
