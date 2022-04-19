#!/bin/bash
PathHome=$(dirname $(readlink -f $0))
PathScript=$(dirname $PathHome)
cd $PathScript
#wget https://github.com/Lolliedieb/lolMiner-releases/releases/download/1.33/lolMiner_v1.33_Lin64.tar.gz
wget https://github.com/Lolliedieb/lolMiner-releases/releases/download/1.48/lolMiner_v1.48_Lin64.tar.gz
tar -xvzf lolMiner_v1.48_Lin64.tar.gz
systemctl stop minerus20.04.mine.service
rm -rf lolMiner
mv 1.48/ lolMiner
sleep 10
systemctl start minerus20.04.mine.service
