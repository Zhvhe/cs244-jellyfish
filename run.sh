#!/bin/bash

# Exit on any failure
set -e

# Check for uninitialized variables
set -o nounset

ctrlc() {
	sudo killall -9 python3
	mn -c
	exit
}

trap ctrlc SIGINT

start=`date`
exptid=`date +%b%d-%H:%M`

rm -rf results

i=0
for e in link_utilization throughput
do
  python3 runner.py -t ft -r hashed --time 30 -s $i --topo-args=4,speed=10 --bw=10 -e $e
  python3 runner.py -t jelly -r hashed --time 30 -s $i --topo-args=0,20,16,bw=10 --bw=10 -e $e
  python3 runner.py -t jelly -r kshortest --time 30 -s $i --topo-args=0,20,16,bw=10 --bw=10 -e $e
done
python3 runner.py -t jelly -r hashed --time 30 -s $i --topo-args=0,20,16,bw=10 --bw=10 -f 8 -e throughput
python3 runner.py -t jelly -r kshortest --time 30 -s $i --topo-args=0,20,16,bw=10 --bw=10 -f 8 -e throughput



python3 jellyfish/jellyfish/result_creation/print_throughputs.py
python3 jellyfish/jellyfish/result_creation/plot_link_util.py -o link_utilization.png

echo "Started at" $start
echo "Ended at" `date`
