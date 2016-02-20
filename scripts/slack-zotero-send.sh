#!/bin/bash

channel=\"#literature\";
username=\"zotero_bot\";
icon_emoji=\":cow:\";
URL='https://hooks.slack.com/services/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'
while read TEXT; do
    echo curl -s -X POST --data-urlencode \'payload={\"channel\": $channel, \"username\": $username, \"text\": \"$TEXT\", \"icon_emoji\": $icon_emoji}\' $URL | sh
    echo $TEXT >> $HOME/slack-zotero.log
    date >> $HOME/slack-zotero.log
    sleep 2
done
exit 0


## Run with:

## nohup feedstail -e -i 5 -r -f {title}__{author}__{link} -u
## "https://api.zotero.org/groups/484592/items/top?start=0&limit=25&format=atom&v=1"
## | dotfiles/scripts/slack-zotero-send.sh
