#!/bin/bash
ssh -Y  -c arcfour,blowfish-cbc -C 129.13.174.229 -t 'screen -x';
if [ $? -ne 0 ] ;
then
    echo 'No route to host beagle' ;
fi ;
