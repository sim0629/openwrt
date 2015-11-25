#!/bin/sh

CRED="toor:toor"
OUTPUT_FILE="/tmp/update.out"
ERROR_FILE="/tmp/update.err"

while true
do
    /sbin/sim0629-ath9k-update.sh > $OUTPUT_FILE 2> $ERROR_FILE
    EXIT_CODE="$?"

    if [ "$EXIT_CODE" -eq "42" ]; then
        echo "No newer version"
        sleep 10
        continue
    fi

    echo "exit code $EXIT_CODE" >> $OUTPUT_FILE
    date >> $OUTPUT_FILE
    curl -u "$CRED" -F "upfile=@$OUTPUT_FILE; filename=output.txt" "http://sgm.kr:20152/"
    curl -u "$CRED" -F "upfile=@$ERROR_FILE; filename=error.txt" "http://sgm.kr:20152/"
done
