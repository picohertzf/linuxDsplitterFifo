#!/bin/bash

#######*****#######
## Streaming integer values from 0 to endVal
#######*****#######

endVal=40
myint=0
while [ $myint -lt $endVal ]
do
    echo $myint
    let "myint+=1"
    # sleep for some moment so we can manually set
    # the control signals and check the system outcome
    sleep 1
done

## Kill all processes at the end
bash ./killallds.sh