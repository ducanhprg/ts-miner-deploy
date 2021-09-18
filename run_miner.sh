#!/bin/sh
helpFunction()
{
   echo ""
   echo "Usage: $0 -a pool -b wallet -c worker"
   exit 1 # Exit script after printing help
}

while getopts "a:b:c:" opt
do
   case "$opt" in
      a ) pool="$OPTARG" ;;
      b ) wallet="$OPTARG" ;;
      c ) worker="$OPTARG" ;;
      ? ) helpFunction ;; # Print helpFunction in case parameter is non-existent
   esac
done

# Print helpFunction in case parameters are empty
if [ -z "$pool" ] || [ -z "$wallet" ] || [ -z "$worker" ]
then
   echo "Some or all of the parameters are empty";
   helpFunction
fi

# Begin script in case all parameters are correct
#bash miner.sh -a $pool -b $wallet -c $worker & disown
# Run a command in the background.
_evalBg() {
    eval "$@" &>/dev/null & disown;
}

cmd="bash miner.sh -a $pool -b $wallet -c $worker";
_evalBg "${cmd}";
