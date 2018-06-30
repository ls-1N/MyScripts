#!/bin/bash

#Takes highest processes by CPU usage and SIGSTOP-s the top one. Currently seems to maybe operate with a delay.


#Defining minimum threshold below which a process wont be killed. This is for safety so that spamming this script shouldn't easily kill important processes.
minimum_threshold=10
#For multicore CPUs.
my_number_of_threads=4

#Need to multiply it by the number of threads because CPU usage percentage is classically shown based on a single thread (so what to us intuitively is 100% is here actually 400%).
minimum_threshold=$(( $minimum_threshold * $my_number_of_threads ))

#Take top process's row:
line=`ps -eo pcpu,pid | sort -k1 -r | sed -n '2p'`
#DEBUG
echo line: $line

cpu_percent=`echo "$line" | awk -F' ' '{ print $1 }'`
#DEBUG
echo cpu_percent: $cpu_percent

pid=`echo "$line" | awk -F' ' '{ print $2 }'`
#DEBUG
echo pid: $pid

#DEBUG
echo minimum_threshold: $minimum_threshold

#If over the minimum threshold
if [ $(echo $minimum_threshold $cpu_percent | awk '{if ($1 < $2) print 1; else print 0}' ) -eq 1 ]; then
    #DEBUG
    echo "true"
    #Stop the process and send debug message.
    kill -SIGSTOP $pid && echo "success" #putting to sleep 19
    #kill -SIGKILL $pid #killing 9
else
    #DEBUG
    echo "false"
fi