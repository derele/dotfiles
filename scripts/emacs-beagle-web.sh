#!/bin/bash
ssh -Y  -c arcfour,blowfish-cbc -C 129.13.174.229 -t 'emacs-web.sh "'$1'"'