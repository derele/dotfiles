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


