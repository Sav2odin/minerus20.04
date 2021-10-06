#https://github.com/wbryan78124/Ubuntu-18.04-server-xmr
#На сервере:
Upon boot, go into the motherboard bios and set the following options (set as many of these options as you can find):
set IOMMU to ENABLE.
set VIRTUALIZATION (C1E) to DISABLE.
set POWER CONTROL (SVM) to DISABLE.
set CPU UNLOCK to ENABLE (this may prevent CPU temp from being read properly).
set COOL AND QUIET to DISABLE.
set CPU CORE CONTROL equal to the amount of CORES PER PROCESSOR for your particular CPU make/model.
set ONBOARD AUDIO/SOUND (AZALIA) to DISABLE.
set IEEE1394 to DISABLE.
set APU ONBOARD GRAPHICS to DISABLE.
set CPU FREQUENCY SCALING to DISABLE.
set CPU PERFORMANCE MODE to ENABLE.
set FAST BOOT to DISABLE.
sudo passwd root (t2~)
sudo apt install openssh-server
ip a
<192.168.1.183>
**

ssh-copy-id ethereum@100ratel06
ssh ethereum@100ratel06
sudo apt update
# sudo apt dist-upgrade
# sudo reboot
uname -r
<5.4.0-84-generic>
# Нужны драйвера для этого ядра amdgpu-pro-21.30-1290604-ubuntu-20.04.tar.xz
# Если ядро слишком свежее, редактируем grub для загрузки  совместимого с  rocm  ядра ( наше 5.4.0-84-generic)
sudo add-apt-repository ppa:danielrichter2007/grub-customizer 
sudo apt-get update 
sudo apt-get install grub-customizer
#^Если ядро слишком свежее, редактируем grub для загрузки  совместимого с  rocm  ядра ( наше 5.4.0-84-generic)
exit
scp dist/amdgpu-pro-21.30-1290604-ubuntu-20.04.tar.xz ethereum@100ratel07:/home/ethereum/
ssh ethereum@100ratel07
tar -Jxvf amdgpu-pro-21.30-1290604-ubuntu-20.04.tar.xz
sudo usermod -a -G video $LOGNAME
cd amdgpu-pro-21.30-1290604-ubuntu-20.04
./amdgpu-pro-install --opencl=pal,legacy --headless -y 
sudo apt install clinfo
clinfo
    sudo reboot
sudo nano /etc/default/grub
<
#GRUB_CMDLINE_LINUX_DEFAULT="quiet splash amdgpu.vm_fragment_size=9"
GRUB_CMDLINE_LINUX_DEFAULT="iommu=soft amdgpu.ppfeaturemask=0xffffffff text amdgpu.vm_fragment_size=9 radeon.si_support=0 amdgpu.si_support=1 amdgpu.dpm=1 net.ifnames=0 biosdevname=0"
>
sudo update-grub

exit

scp autofan.bash   ethereum@100ratel07:/home/ethereum/
sudo ./autofan.bash 
scp dist/lolMiner_v1.31_Lin64.tar.gz  ethereum@100ratel07:/home/ethereum/
tar xfvz lolMiner_v1.31_Lin64.tar.gz
mkdir Mining
mv -if 1.31/ Mining/lolMiner
ls Mining/lolMiner/
**
sudo su
nano /etc/systemd/system/miningFan.service
<
[Unit]
Description=Amd card fan  mining
After=syslog.target
Wants=graphical.target

[Service]
Type=simple
WorkingDirectory=/home/ethereum
User=root
ExecStart=/bin/bash /home/ethereum/autofan.bash
KillMode=process
Restart=always

[Install]
WantedBy=multi-user.target
#systemctl daemon-reload
#systemctl status miningFan.service
#systemctl enable miningFan.service
>
systemctl daemon-reload
systemctl status miningFan
systemctl enable miningFan
systemctl start miningFan
#\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

nano mlog.sh
<
tail -f /home/ethereum/logs
>
chmod +x mlog.sh 

#Miner:
#mkdir Mining
#cd Mining
#wget https://github.com/Lolliedieb/lolMiner-releases/releases/download/1.31/#lolMiner_v1.31_Lin64.tar.gz
#tar -xvzf lolMiner_v1.31_Lin64.tar.gz 
#mv 1.31/ lolMiner


#nano /home/ethereum/Mining/lolMiner/mine_etc.sh
<
#!/bin/bash
/home/ethereum/Mining/amdcovc-0.4.1.1/amdcovc.sh
################################
POOL=etc-eu1.nanopool.org:19999
WALLET=0x7e24c70d0a94b0b8a0ecbc8b26e5898a491af384.100ratel07/Sav2odin@gmail.com
################################
cd "$(dirname "$0")"
./lolMiner --algo ETCHASH --pool $POOL --user $WALLET –statsformat speed,poolHr,shares,sharesPerMin,bestShare,power,hrPerWatt,wattPerHr,coreclk,memclk,coreT,juncT,memT,fanPc --logfile ../../logs --log on
>
#chmod +x /home/ethereum/Mining/lolMiner/mine_etc.sh
scp /home/office/Site/amdmining/mine.conf ethereum@100ratel07:/home/ethereum/
scp /home/office/Site/amdmining/mine.sh ethereum@100ratel07:/home/ethereum/

sudo su
nano /etc/systemd/system/amdmining.service
<
[Unit]
Description=Amd card mining
After=syslog.target
#After=graphical.target
#After=multi–user.target
After=network.target
Wants=graphical.target
[Service]
Type=simple
WorkingDirectory=/home/ethereum/
User=root
ExecStart=/home/ethereum/mine.sh 
KillMode=process
TimeoutSec=300
[Install]
WantedBy=multi-user.target 
#systemctl daemon-reload
#systemctl status amdmining.service
#systemctl enable amdmining.service
>
systemctl daemon-reload
systemctl status amdmining
systemctl enable amdmining


*
#Настройка брандмауера
sudo ufw app list
#\/
Available applications:
  Nginx Full
  Nginx HTTP
  Nginx HTTPS
  OpenSSH
#^
sudo ufw allow 'Nginx HTTP'
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

sudo ufw status verbose

#Status: inactive
sudo ufw enable
*
Отключаем автообновление пакетов
sudo systemctl stop apt-daily.timer
sudo systemctl disable apt-daily.timer
sudo systemctl disable apt-daily.service
sudo systemctl daemon-reload
sudo su
sudo apt-get remove unattended-upgrades


*Оптимизация и даунвольт
sudo apt install pciutils libpci-dev libncurses-dev
cd Mining/
wget https://github.com/matszpk/amdcovc/archive/refs/tags/0.4.1.1.tar.gz
tar -xvzf 0.4.1.1.tar.gz
cd amdcovc-0.4.1.1/
make
./amdcovc -v
nano /home/ethereum/Mining/amdcovc-0.4.1.1/amdcovc.sh
<
#!/bin/bash
cd "$(dirname "$0")"
./amdcovc ccoreclk:0=900 
./amdcovc ccoreclk:1=900
./amdcovc ccoreclk:2=900
./amdcovc ccoreclk:3=900
./amdcovc ccoreclk:4=900 
>

chmod +x /home/ethereum/Mining/amdcovc-0.4.1.1/amdcovc.sh
cd /home/ethereum/Mining/amdcovc-0.4.1.1/
sudo ./amdcovc.sh

***********************************************************
sudo add-apt-repository ppa:ethereum/ethereum
sudo apt update
sudo apt install ethereum

# Отключаем графическую оболочку https://www.cryptoprofi.info/?p=4949
sudo su
systemctl enable multi-user.target
systemctl set-default multi-user.target

systemctl status gdm3
systemctl stop gdm3
systemctl disable gdm3
reboot
systemtcl start  gdm3
clinfo -l
# если нужна оболочка:
#$ login:ethereum/pass21
#$ systemtcl start  gdm3 :/pass21

*********
# Можно, если интеренсо, посмотреть что это за чудо такое cloud-init и где он расположился?
apt-cache search cloud-init
#2. Поняв, что это нам не нужно — сносим:
sudo bash -c "echo 'datasource_list: [ None ]' sudo -s tee /etc/cloud/cloud.cfg.d/90_dpkg.cfg"
sudo apt-get purge -y cloud-init
sudo rm -rf /etc/cloud/; sudo rm -rf /var/lib/cloud/
sudo reboot
***********
* netplan
sudo nano /etc/default/grub
<
# Уже добавили: GRUB_CMDLINE_LINUX_DEFAULT="net.ifnames=0 biosdevname=0"
>

ls /sys/class/net/
> eth0  lo  # появился eth0
nano /etc/netplan/00-installer-config.yaml 
<
# This is the network config written by 'subiquity'
network:
  ethernets:
    eth0:
      dhcp4: true
  version: 2
>
*
netplan generate
netplan apply

sudo ip a
*
#https://fsen.ru/linux/gpt-mbr перенос дисков
#https://linuxconfig.org/how-to-list-create-delete-partitions-on-mbr-and-gpt-disks-rhcsa-objective-preparation
