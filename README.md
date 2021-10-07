# minerus20.04 #
*Mining script for Ubuntu Server 20.04* Ubuntu сервисы для майнинга, логи и конфиги по умолчанию. **Worker = $(hostname)** имя воркера на "майнинг" пуле совпадает с именем хоста убунту. Все пути и имена вписываются в сервисы и конфиги автоматически.
*********
 ## Настраиваем систему Ubuntu Server для майнинга ##
 1. Check kernel
```
uname -r
```
 >5.4.0-84-generic

 2. For this kernel install [amdgpu-pro-21.30-1290604-ubuntu-20.04.tar.xz](https://www.amd.com/en/support/kb/release-notes/rn-amdgpu-unified-linux-20-50) 
```
tar -Jxvf amdgpu-pro-21.30-1290604-ubuntu-20.04.tar.xz &&cd amdgpu-pro-21.30-1290604-ubuntu-20.04 &&./amdgpu-pro-install --opencl=pal,legacy --headless -y
``` 
 3. Modify gbrub, netplan setup. 
``` 
sudo nano /etc/default/grub
``` 
```
GRUB_CMDLINE_LINUX_DEFAULT="iommu=soft amdgpu.ppfeaturemask=0xffffffff text amdgpu.vm_fragment_size=9 radeon.si_support=0 amdgpu.si_support=1 amdgpu.dpm=1 net.ifnames=0 biosdevname=0"
``` 
```
sudo update-grub
```
```		
ls /sys/class/net/
```
 >eth0 появится после reboot, но сеть работать не будет! Значит меняем "netplan" до reboot чтобы не терять сеть:
```
nano /etc/netplan/00-installer-config.yaml # или ваши буквы после 00-??????
```
``` 
network:
  ethernets:
    eth0:
      dhcp4: true
  version: 2
```
```
netplan generate &&netplan apply 
```
*********
 ##Подготовка системы закончена, ставим управление вентиляторами, управление видеокартами, майнер, сервис майнинга, Firewall. ##

 4. Install auto-fan service (сервис выбора скорости вентилятора от температуры карты)
```
./mining_fan.service.create.sh
```
 5. Install amdcovc ( оптимизация и даунвольт )
```
./amdcovc.create.sh 
``` 
 6. Install miner lolminer ( программа майнер )
```
./lolMiner.create.sh
```
 7. Install mine service ( сервис автостарта майнера )
```
./mining_mine.service.create.sh
``` 
 8. Setup a Firewall with UFW ( фаервол )
 ```
./ufw.setup.sh
 ```
*********
##Тонкая настройка##
 Кошельки ETH,ETC,Zil ( по умолчанию всё настроено, достаточно поменять ETC адрес )
```
../minerus20.04.conf.sh 
```
 Логи текущего майнинга
```
../minerus20.04.log.sh
```
 Cнижение температуры и мощности:
```
../amdcovc-0.4.1.1/amdcovc -v
```
 >cмотрим возможное значения и понижаем частоту ядра в скрипте ../amdcovc-0.4.1.1/amdcovc.sh - для каждой карты разное. Проверяем запустив
``` 
  ../amdcovc-0.4.1.1/amdcovc.sh
```
*********