#!/bin/bash

#######*****#######
## Orchestrator: start processes in required order
#######*****#######

### 1st: Create the FIFOs
echo -e '\n*** Step 1 ***'

## Make the FIFOs if they don't exist
datafifo1=./datafifo1
datafifo2=./datafifo2

if [ -p $datafifo1 ]
then
    rm $datafifo1
    echo Removed old $datafifo1
fi
mkfifo $datafifo1
echo Created $datafifo1

if [ -p $datafifo2 ]
then
    rm $datafifo2
    echo Removed old $datafifo2
fi
mkfifo $datafifo2
echo Created $datafifo2

### 2nd: Create consumers
echo -e '\n*** Step 2 ***'
bash ./consumerfactory.sh con1 con2

### 3rd: Run the datastreamer and pipe to stream splitter
echo -e '\n*** Step 3 ***'
# Runs the data streamer under process name datastreamer (exec -a datastreamer)
# Runs the stream plitter under process name datasplitter (exec -a datasplitter)
exec -a datastreamer bash ./datastreamer.sh | exec -a datasplitter bash ./streamsplitter.sh $datafifo1 $datafifo2 &

### 4th: Start the FIFO consumers
echo -e '\n*** Step 4 ***'
## Creating their signal controls
echo 0 > ./signalcon1
echo 0 > ./signalcon2
## Running the consumers
exec -a con1p bash ./con1.sh $datafifo1 ./signalcon1 &
exec -a con2p bash ./con2.sh $datafifo2 ./signalcon2 &