#!/bin/bash
ssh -Y  -c arcfour,blowfish-cbc -C beagle -t 'screen -x';
if [ $? -ne 0 ] ;
then
    echo 'No route to host beagle' ;
fi ;
