#!/bin/bash
PathHome=$(dirname $(readlink -f $0))
ProjectName="${PathHome##*/}"

echo "[Unit]
Description=Amd card fan  mining
After=syslog.target
Wants=graphical.target

[Service]
Type=simple
WorkingDirectory="$PathHome"
User=root
ExecStart=/bin/bash "$PathHome"/fan.bash
KillMode=process
Restart=always

[Install]
WantedBy=multi-user.target
#systemctl daemon-reload
#systemctl status "$ProjectName".fan.service
#systemctl enable "$ProjectName".fan.service
" > miningFan.service

sudo systemctl stop $ProjectName.fan.service
sudo systemctl disable $ProjectName.fan.service
sudo rm /etc/systemd/system/$ProjectName.fan.service

sudo mv miningFan.service "/etc/systemd/system/$ProjectName.fan.service"
sudo systemctl daemon-reload
sudo systemctl start $ProjectName.fan.service
sudo systemctl enable $ProjectName.fan.service
sudo systemctl status $ProjectName.fan.service
#systemctl disable miningFan.service
#systemctl stop miningFan.service
#rm /etc/systemd/system/miningFan.service
#sudo systemctl daemon-reload
