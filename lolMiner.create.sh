#!/bin/bash
PathHome=$(dirname $(readlink -f $0))
PathScript=$(dirname $PathHome)
cd $PathScript
wget https://github.com/Lolliedieb/lolMiner-releases/releases/download/1.33/lolMiner_v1.33_Lin64.tar.gz
tar -xvzf lolMiner_v1.33_Lin64.tar.gz
mv 1.33/ lolMiner