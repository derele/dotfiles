#!/bin/bash
ssh -Y  -c arcfour,blowfish-cbc eheitlin@cluster -t 'screen -x';
if [ $? -ne 0 ] ;
then
    echo 'No route to host beagle' ;
fi ;
