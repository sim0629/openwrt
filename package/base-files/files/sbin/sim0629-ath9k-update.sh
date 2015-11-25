#!/bin/sh

CRED="toor:toor"

NEW_VERSION=`curl -u "$CRED" "http://sgm.kr:20152/version.txt" 2> /dev/null || echo '-1'`
CUR_VERSION=`cat /tmp/version.txt 2> /dev/null || echo '-1'`

if [ "$CUR_VERSION" -ge "$NEW_VERSION" ]; then
    exit 42
fi
echo "$NEW_VERSION" > /tmp/version.txt

curl -u "$CRED" "http://sgm.kr:20152/ath9k.ko" -o /tmp/ath9k.ko && 2> /dev/null \
curl -u "$CRED" "http://sgm.kr:20152/ath9k_common.ko" -o /tmp/ath9k_common.ko 2> /dev/null && \
curl -u "$CRED" "http://sgm.kr:20152/ath9k_hw.ko" -o /tmp/ath9k_hw.ko 2> /dev/null || \
exit 1

rmmod ath9k
rmmod ath9k_common
rmmod ath9k_hw
rmmod ath
rmmod mac80211
rmmod cfg80211
rmmod compat

modprobe mac80211
modprobe ath
insmod /tmp/ath9k_hw.ko
insmod /tmp/ath9k_common.ko
insmod /tmp/ath9k.ko

lsmod

/etc/init.d/network restart

sleep 5

