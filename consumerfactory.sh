#!/bin/bash

#######*****#######
## Create a consumer script with the name and for each given name in the arguments
#######*****#######

for var in "$@"
do
    consumer_name=$var

    ## Remove if exisits, remove the old file
    if [ -e ./$consumer_name.sh ]
    then
        rm ./$consumer_name.sh
        echo Removed the old $consumer_name.sh file
    fi
    ## Create from template
    cat ./consumertemplate.sh > ./$consumer_name.sh
    echo Created $consumer_name.sh file from the template
done