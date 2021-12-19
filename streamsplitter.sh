#!/bin/bash

#######*****#######
## Data stream splitter
## Will split input data stream that is piped into this 
## process into 2 similar output streams (duplicate the input) and the standard output
#######*****#######

## Name of the named pipes or FIFos received in arguments
datafifo1=$1
datafifo2=$2


## Check if there is an input pipe data (this is a normal pipe or anonymous pipe)
if [ -p /dev/stdin ]
then
    cat - | tee $datafifo1 $datafifo2
fi