#!/bin/bash

#systemctl list-units

#systemctl status amdmining.service
systemctl disable amdmining.service
systemctl stop amdmining.service
rm /etc/systemd/system/amdmining.service

#systemctl status miningFan.service
systemctl disable miningFan.service
systemctl stop miningFan.service
rm /etc/systemd/system/miningFan.service
