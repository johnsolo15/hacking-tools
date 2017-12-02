/#!/bin/bash

# Logan Johnson
# Basic bash port scanner
# CS 427 Project 1
# 1/29/2016

if [ $# -eq 5 ]
then
    timeout=$2
    host=$3
    startport=$4
    stopport=$5
    echo "Timeout value changed to $timeout"
elif [ $# -eq 2 ]
then
    timeout=$2
    echo "Timeout value changed to $timeout"
else
    timeout=2
    host=$1
    startport=$2
    stopport=$3
fi
continue=yes

function pingcheck
{
ping=`ping -c 1 $host | grep bytes | wc -l`
if [ "$ping" -gt 1 ];
then
    echo "$host is up"
else
    echo "$host is down, quitting"
    exit
fi
}

function portcheck
{
for ((counter=$startport; counter<=$stopport; counter++))
do
    if timeout $timeout bash -c "echo >/dev/tcp/$host/$counter"
    then
        echo "$counter open"
    else
        echo "$counter closed"
    fi
done
}

if [ $# = 0 -o $# = 2 -o $# = 3 -o $# = 5 ]
then
    :
else
    echo "usage: ./portscanner.sh [-t] [<host> <startport> <stopport>]"
    exit
fi

if [ $# = 0 -o $# = 2 ]
then
    while [[ "$continue" == "yes" ]]
    do
        echo "Enter a host"
        read host
        if [ "$host" = "" ]
	then
            continue=no
            echo "quitting"
        else
            echo "Enter a start port"
            read startport
            echo "Enter a stop port"
            read stopport
            continue=yes
            pingcheck
            portcheck
        fi

    done
else
    pingcheck
    portcheck
fi
