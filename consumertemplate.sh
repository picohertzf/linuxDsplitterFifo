#!/bin/bash

#######*****#######
## Consumer template used with the consumer factory for creating data consumers
#######*****#######

## The FIFO to be consumed
consumerFIFO=$1

## The consumer control signal: to consume or not.
## If signal file content is equal to 1, consumer will be on, and off in any other case
controlSignal=$2

## Create a logs folder if does not exist
if [ ! -d ./logs ]
then
    mkdir ./logs
else
    # Delete all existing log files in the exisiting logs folder
    rm ./logs/*.log
fi

## Create a dummy consumer
# For the name, finds the name of the consumer file, 
# removes the .sh and adds 'dum' at the end, removes the ./ in the prefix
dumconsumername=$(echo $BASH_SOURCE | sed 's/.sh/dum/' | sed 's/.\///')
bash ./dummyconsumerfactory.sh $dumconsumername
## Start the dummy consumer for the FIFO
setsid bash ./$dumconsumername.sh $consumerFIFO


## Read the sginal file for the first time
signal=$(cat ./$controlSignal)

if [ -p ./$consumerFIFO ]
then
    # Alternative to $BASH_SORUCE for filename is ${0##*/}
    logfilename=./logs/$(echo $BASH_SOURCE | sed 's/.sh/.log/' | sed 's/.\///')
    rm $logfilename 2> /dev/null
    echo Output gets written to $logfilename
    # Process name
    conprocessname=$(echo $BASH_SOURCE | sed 's/.sh//' | sed 's/.\//process/')
    # Consumer process status
    conpstatus=0


    echo Consumer process name is $conprocessname
    while :
    do
        if [ "$signal" == "1" ]
        then
            if [ "$conpstatus" == "0" ] # check if it is not already active, avoid running in the while
            then
                echo Signal is $signal
                conpstatus=1
                exec -a $conprocessname cat ./$consumerFIFO >> $logfilename &
                pkill -f dummy$dumconsumername
            fi
        else
            if [ "$conpstatus" == "1" ] # check if it is already active
            then
                # Start the dummy consumer for the FIFO
                setsid bash ./$dumconsumername.sh $consumerFIFO

                echo Killing consumer Process
                pkill -f $conprocessname
                conpstatus=0
            fi
        fi
        
        signal=$(cat ./$controlSignal)
    done
fi
