#!/bin/bash
ssh -Y  -c arcfour,blowfish-cbc -C 141.20.60.82 -t 'screen -x';
if [ $? -ne 0 ] ;
then
    echo 'No route to host svalbard' ;
fi ;
