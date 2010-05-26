#!/bin/bash
grep -Ev 'Signif. codes:' $1
echo "library(weaver); Sweave(\"$1\", driver=weaver())" \
| R --no-save --no-restore
