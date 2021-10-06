#!/bin/bash
#Настройка брандмауера
sudo ufw allow ssh
sudo ufw allow 7321
sudo ufw allow https
sudo ufw allow proto tcp from any to any port 80,443
sudo ufw allow 25
sudo ufw allow 587
sudo ufw allow 143
sudo ufw allow 993
sudo ufw allow 110
sudo ufw allow 995

sudo ufw enable
sudo ufw status verbose
