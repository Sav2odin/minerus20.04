# minerus20.04
Mining script for Ubuntu Server v20.04
## Настраиваем систему для майнинга
#### 1) Check kernel
 > uname -r
 >5.4.0-84-generic

#### 2) For this kernel install amdgpu-pro-21.30-1290604-ubuntu-20.04.tar.xz (https://www.amd.com/en/support/kb/release-notes/rn-amdgpu-unified-linux-20-50)
 > tar -Jxvf amdgpu-pro-21.30-1290604-ubuntu-20.04.tar.xz &&cd amdgpu-pro-21.30-1290604-ubuntu-20.04 &&./amdgpu-pro-install --opencl=pal,legacy --headless -y 

#### 3) Modify gbrub, netplan setup.
 > sudo nano /etc/default/grub
 
   GRUB_CMDLINE_LINUX_DEFAULT="iommu=soft amdgpu.ppfeaturemask=0xffffffff text amdgpu.vm_fragment_size=9 radeon.si_support=0 amdgpu.si_support=1 amdgpu.dpm=1 net.ifnames=0 biosdevname=0"
 
 > sudo update-grub
 
 > ls /sys/class/net/

	eth0  lo  
	# eth0 появится после reboot (сеть работать не будет, меняем "netplan" до reboot чтобы не терять сеть)
 
 > nano /etc/netplan/00-installer-config.yaml # или ваши буквы после 00-??????

	network:
	  ethernets:
	    eth0:
	      dhcp4: true
	  version: 2

 > netplan generate &&netplan apply
##  Подготовка системы закончена, ставим управление вентилятором, управление частотой ядра, майнер, сервис майнинга, Firewall.
#### 4) Install auto-fan service
 > ./mining_fan.service.create.sh 
#### 5) Install amdcovc (Оптимизация и даунвольт)
 > ./amdcovc.create.sh 
#### 6) Install miner lolminer
 > ./lolMiner.create.sh
#### 7) Install mine service
 > ./mining_mine.service.create.sh
#### 8) Setup a Firewall with UFW
 > ./ufw.setup.sh
##  Тонкая настройка
 > ../minerus20.04.conf.sh # Кошельки и адреса пулов (для настройки достаточно иметь адреса: ETH,ETC,Zil)

 > ../minerus20.04.log.sh # Логи текущего майнинга

 > ../amdcovc-0.4.1.1/amdcovc -v 

	Смотрим разрешённые значения и понижаем частоту ядра в ../amdcovc-0.4.1.1/amdcovc.sh для снижения температуры и мощности, проверяем запустив ../amdcovc-0.4.1.1/amdcovc.sh

