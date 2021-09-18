#!/bin/bash
set -e

helpFunction()
{
   echo ""
   echo "Usage: bash $0 -a source_miner_url"
   echo -e "\t-a Example: https://github.com/trexminer/T-Rex/releases/download/0.21.6/t-rex-0.21.6-linux.tar.gz"
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
   echo "y";
   helpFunction
fi

# Begin script in case all parameters are correct
echo "Removing current miner..."
rm -rf t-rex

echo "Getting new source miner..."

wget -O tmp.tar.gz $source_miner_url

echo "Creating tmp folder..."
mkdir tmp

echo "Extracting source miner..."
tar -xf tmp.tar.gz --directory tmp

echo "Copying source miner to root..."
cp tmp/t-rex .

echo "Cleaning...."
rm -rf tmp*
ls -la

echo "Pushing change to repository"
git add --all
git commit -m "Updating source miner"
git push
