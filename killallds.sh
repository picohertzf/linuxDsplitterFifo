#!/bin/bash
pkill -f datasplitter
pkill -f datastreamer
pkill -f dummycon1dum
pkill -f dummycon2dum
pkill -f tee
pkill -f con1p
pkill -f con2p
rm datafifo*