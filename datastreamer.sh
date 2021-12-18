#!/bin/bash

## Streaming integer values from 0 to xxx
myint=0
while [ $myint -lt 50 ]
do
    echo $myint
    let "myint+=1"
    sleep 1.1
done

## Kill all processes at the end
bash ./killallds.sh