#!/bin/bash
running=$(screen -ls | grep "Socket" | awk -F " " '{print $1}')

case "$running" in 
    [0-9] ) 
        export TERM=xterm-256color
        screen -x        
        ;;
    * ) 
        export TERM=xterm-256color
        screen        
        ;;
esac