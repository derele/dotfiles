#!/bin/bash

nohup feedstail -e -i 600 -r -f {title}__{author}__{link} -u "https://api.zotero.org/groups/484592/items/top?start=0&limit=25&format=atom&v=1" | $1
