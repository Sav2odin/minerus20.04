# minerus20.04 #
_Mining script for **Ubuntu Server 20.04**_ 
> Ubuntu сервисы с логами и конфигами. **Worker = $(hostname)** имя воркера на "майнинг" пуле совпадает с именем хоста убунту. 
_Все пути и имена вписываются в сервисы автоматически._

* * *
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
return "eth0" to Ubuntu. You add /etc/default/grub " net.ifnames=0 biosdevname=0"
 >eth0 появится после reboot, но сеть работать не будет! Значит меняем "netplan" до reboot чтобы не терять сеть:
```
sudo su &&nano /etc/netplan/00-installer-config.yaml # или ваши буквы после 0?-??????
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
reboot
```
* * *

## Подготовка системы закончена, ставим управление вентиляторами, управление видеокартами, майнер, сервис майнинга, Firewall. ##
 
 4. Install this scripts: ( скрипты с github.com в _~/minerus20.04_ )
```
 git clone https://github.com/Sav2odin/minerus20.04.git &&cd minerus20.04
```
 5. Install auto-fan service (сервис выбора скорости вентилятора от температуры _minerus20.04.fan.service_ )
```
./mining_fan.service.create.sh
```
 6. Install amdcovc ( оптимизация и даунвольт )
```
./amdcovc.create.sh 
``` 
 7. Install miner lolminer ( программа майнер )
```
./lolMiner.create.sh
```
 8. Install mine service ( сервис автостарта майнера _minerus20.04.mine.service_ )
```
./mining_mine.service.create.sh
``` 
 9. Setup a Firewall with UFW ( фаервол )
 ```
./ufw.setup.sh
 ```
* * * 

## Тонкая настройка ##

 Кошельки ETH,ETC,Zil ( по умолчанию всё настроено, достаточно поменять ETC адрес )
```
../minerus20.04.conf.sh 
```
 Логи майнинга
```
../minerus20.04.log.sh
```
 Cнижение температуры и частоты ядра карты:
```
../amdcovc-0.4.1.1/amdcovc -v
```
 >cмотрим возможное значения и понижаем частоту ядра в скрипте ../amdcovc-0.4.1.1/amdcovc.sh - для каждой карты разное. Проверяем запустив
``` 
../amdcovc-0.4.1.1/amdcovc.sh
```
* * * 
