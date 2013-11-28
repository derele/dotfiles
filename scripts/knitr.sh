#!/bin/bash

### TERM=xterm
/usr/bin/Rscript --vanilla -e "library(knitr); knit(\"${1}\")"

# echo "library(knitr); knit(\"$1\")" \
#     | R --no-save --no-restore
