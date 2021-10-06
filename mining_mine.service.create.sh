#!/bin/bash
PathHome="$(dirname $(readlink -f $0))"
ProjectName="mineus20.04"

echo "[Unit]
Description=Amd card mining
After=syslog.target
#After=graphical.target
#After=multi–user.target
After=network.target
Wants=graphical.target
[Service]
Type=simple
WorkingDirectory="$PathHome"
User=root
ExecStart="$PathHome"/mine.sh 
KillMode=process
TimeoutSec=300
[Install]
WantedBy=multi-user.target 
#systemctl daemon-reload
#systemctl status "$ProjectName".mine.service
#systemctl enable "$ProjectName".mine.service
"  > amdmining.service

sudo systemctl stop $ProjectName.mine.service
sudo systemctl disable $ProjectName.mine.service
sudo rm /etc/systemd/system/$ProjectName.mine.service

sudo mv amdmining.service "/etc/systemd/system/$ProjectName.mine.service"
sudo systemctl daemon-reload
sudo systemctl enable $ProjectName.mine.service
sudo systemctl start $ProjectName.mine.service
sudo systemctl status $ProjectName.mine.service

#sudo systemctl stop amdmining.service &&sudo systemctl disable amdmining.service &&sudo rm /etc/systemd/system/amdmining.service &&sudo systemctl daemon-reload
