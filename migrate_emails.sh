#!/bin/bash
mkdir -p LOG

{ while IFS=';' read  u1 p1 u2 p2
do
    { echo "$u1" | egrep "^#" ; } > /dev/null && continue
        NOW=`date +%Y_%m_%d_%H_%M_%S`
        echo syncing to user "$u2"
        imapsync --host1 <imapserverA> --user1 "$u1" --password1 "$p1" \
            --ssl2 --host2 <imapserverB> --user2 "$u2" --password2 "$p2" \
            --delete2 --delete2folders  --expunge2 -uidexpunge2 \
            --useheader 'Message-Id'  --useuid \
            2> LOG/log_${u2}_$NOW.txt > /dev/null
    done
} < users.txt
