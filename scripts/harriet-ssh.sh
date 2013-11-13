#!/bin/bash
ssh -Y  -c arcfour,blowfish-cbc -C harriet -t 'screen -x';
if [ $? -ne 0 ] ;
then
    echo 'No route to host harriet' ;
fi ;
