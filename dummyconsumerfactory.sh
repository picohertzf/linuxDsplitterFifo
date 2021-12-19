#!/bin/bash

#######*****#######
## Dummy consumer factory
## Called from data consumers, to create a dummy data consumer with the given name in the arguments
## Generally only one name in the arguments is passed, but the code can handle multiple arguments
#######*****#######

for var in "$@"
do
    dummy_name=$var

    ## Remove if exisits, remove the old file
    if [ -e ./$dummy_name.sh ]
    then
        rm ./$dummy_name.sh
        echo Removed the old $dummy_name.sh file
    fi
    ## Create from template
    cat ./dummyconsumertemplate.sh > ./$dummy_name.sh
    echo Created $dummy_name.sh file from the template
done
