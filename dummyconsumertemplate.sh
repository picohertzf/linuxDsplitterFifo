#!/bin/bash

#######*****#######
## Dummy consumer template used by dummy consumer factory
#######*****#######

# This name is assigned to the dummy cat process
# For the name, it finds the name of the dummy consumer file name, removes the .sh at the end,
# removes the ./ in the beginning, and add 'dummy' as a prefix
dummyname=$(echo $BASH_SOURCE | sed 's/.sh//' | sed 's/.\//dummy/')
exec -a $dummyname cat <>$1 1> /dev/null &