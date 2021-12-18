#!/bin/bash

## Dummy consumer

dummyname=$(echo $BASH_SOURCE | sed 's/.sh//' | sed 's/.\//dummy/')
exec -a $dummyname cat <>$1 1> /dev/null &