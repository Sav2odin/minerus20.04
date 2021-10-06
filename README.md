# minerus20.04
# For Ubuntu Server v20.04
# Настраиваем систему для майнинга
# 1) Check kernel
# > uname -r
# >5.4.0-84-generic
#
# 2) For this kernel instal amdgpu-pro-21.30-1290604-ubuntu-20.04.tar.xz (https://www.amd.com/en/support/kb/release-notes/rn-amdgpu-unified-linux-20-50)
# > tar -Jxvf amdgpu-pro-21.30-1290604-ubuntu-20.04.tar.xz &&cd amdgpu-pro-21.30-1290604-ubuntu-20.04 &&./amdgpu-pro-install --opencl=pal,legacy --headless -y 
#
# 3) Modifi gbrub, netplan setup.
# > sudo nano /etc/default/grub
#  <
#  #GRUB_CMDLINE_LINUX_DEFAULT="quiet splash amdgpu.vm_fragment_size=9"
#  GRUB_CMDLINE_LINUX_DEFAULT="iommu=soft amdgpu.ppfeaturemask=0xffffffff text amdgpu.vm_fragment_size=9 radeon.si_support=0 amdgpu.si_support=1 amdgpu.dpm=1 net.ifnames=0 biosdevname=0"
#  > {ctrl+x}
# > sudo update-grub
# > ls /sys/class/net/
# >eth0  lo  # eth0 появится после reboot (сеть работать не будет, меняем "netplan" до reboot чтобы не терять сеть)
# > nano /etc/netplan/00-installer-config.yaml # или ваши буквы после 00-??????
#	network:
#	  ethernets:
#	    eth0:
#	      dhcp4: true
#	  version: 2
# > netplan generate
# > netplan apply
#  Подготовка системы закончена, ставим управление вентилятором, управление частотой ядра, майнер, сервис майнинга
# 4) Install auto-fan service
# > ./mining_fan.service.create.sh 
# 5) Install amdcovc (Оптимизация и даунвольт)
# > ./amdcovc.create.sh 
# 6) Install miner lolminer
# > ./lolminer.download.sh
# 7) Install mine service
# > ./mining_mine.service.create.sh