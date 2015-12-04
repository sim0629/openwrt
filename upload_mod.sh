#!/bin/bash

orig=`pwd`
cd staging_dir/target-mips_34kc_uClibc-0.9.33.2/root-ar71xx/lib/modules/3.10.49/ || exit 1

curl -u 'toor:toor' -F "upfile=@ath.ko" "http://sgm.kr:20152/"
curl -u 'toor:toor' -F "upfile=@ath9k.ko" "http://sgm.kr:20152/"
curl -u 'toor:toor' -F "upfile=@ath9k_hw.ko" "http://sgm.kr:20152/"
curl -u 'toor:toor' -F "upfile=@ath9k_common.ko" "http://sgm.kr:20152/"
curl -u 'toor:toor' -F "upfile=@mac80211.ko" "http://sgm.kr:20152/"
curl -u 'toor:toor' "http://sgm.kr:20152/version.txt" -o version.txt
n=`cat version.txt`
n=$(($n+1))
echo $n > version.txt
curl -u 'toor:toor' -F "upfile=@version.txt" "http://sgm.kr:20152/"

cd "$orig"
