#!/bin/bash
ssh -Y  -c arcfour,blowfish-cbc -C emanuel@oberon.bio.ed.ac.uk -t 'screen -x';
if [ $? -ne 0 ] ;
then
    echo 'No route to host oberon.bio.ed.ac.uk' ;
fi ;
