#!/bin/bash
PathHome=$(dirname $(readlink -f $0))
#$(cd "$(dirname "$0")"; pwd)
PathScript=$(dirname $PathHome)
PathConf=$PathScript
PathLogs="$PathConf"
ProjectName="${PathHome##*/}"
echo "$PathHome"
# Configurations
if [ -e $PathConf/$ProjectName.conf ]
then
	echo "Config: $PathConf/$ProjectName.conf"
	echo "Logfile: $PathLogs/$ProjectName.log"
else
	cp $PathHome/mine.conf.default "$PathConf/$ProjectName.conf" 
	echo "sudo nano "$PathConf"/"$ProjectName".conf" > "$PathScript/$ProjectName.conf.sh"
	sudo chmod +x  "$PathScript/$ProjectName.conf.sh"
	echo "tail -f "$PathLogs"/"$ProjectName".log" > "$PathScript/$ProjectName.log.sh"
	sudo chmod +x  "$PathScript/$ProjectName.log.sh"
fi
source $PathConf/$ProjectName.conf
#/Configurations
echo $Timeout
declare -i nTimeout=$Timeout
if [ $nTimeout -ge 1 ]
	 then
	sleep $nTimeout 
else
	sleep 20
fi

$PathScript/amdcovc-0.4.1.1/amdcovc.sh

if [ "$MineName" == "LolMinerEtc" ]
 then
	MinePachBin="$PathScript/lolMiner/lolMiner"
	################################
	POOL="$EtcPool"
	WALLET="$EtcWallet.$Worker/$eMail"
	################################
	cd "$(dirname "$MinePachBin")"
	echo "MineName:$MineName  --pool $POOL --user $WALLET --logfile $PathLogs/$ProjectName.log"
	./lolMiner --algo ETCHASH --pool $POOL --user $WALLET --ethstratum ETHPROXY timeout 10 --logfile $PathLogs/$ProjectName.log --log on
	#– statsformat speed,poolHr,shares,sharesPerMin,bestShare,power,hrPerWatt,wattPerHr,coreclk,memclk,coreT,juncT,memT,fanPc
	cd "$PathHome"
elif [ "$MineName" == "LolMinerEtcZil" ]
 then
	MinePachBin="$PathScript/lolMiner/lolMiner"
	cd "$(dirname "$MinePachBin")"
	echo "MineName:$MineName  --pool $EtcZilPool --user $EtcWallet.$ZilWallet.$Worker --logfile $PathLogs/$ProjectName.log"
	./lolMiner --algo ETCHASH --pool $EtcZilPool --user $EtcWallet.$ZilWallet.$Worker --ethstratum ETHPROXY timeout 10 --logfile $PathLogs/$ProjectName.log --log on
	cd "$PathHome"
 else
 echo "!"
 echo "$MineName" 
fi
# Reboot, from no ping pool or crash lolMiner
if [ ! -v NomineTimeout2Reboot ] #note the lack of a $ sigil
then
    echo "NomineTimeout2Reboot is unset in Config: "$PathConf"/"$ProjectName".conf. To reboot 9 minut"
	sleep 540
	echo "reboot"
elif [ -z "$NomineTimeout2Reboot" ]
then
    echo "NomineTimeout2Reboot empty. No reboot."
else
	#declare -i nTimeout2Reboot=$NomineTimeout2Reboot
	if [ $NomineTimeout2Reboot -gt 0 ]
		 then
	    echo "Timeout2Reboot "
	    echo "$NomineTimeout2Reboot"
		sleep $NomineTimeout2Reboot
		echo "reboot"
	else
	    echo "Timeout2Reboot=0. No reboot."
	fi
fi

#file $ProjectName.conf.default
#echo "This is the sourced code from the data file."
#Worker="100ratel07"
#MineName="LolMinerEtc"
#MinePachBin="/home/ethereum/Mining/lolMiner/lolMiner"
#EtcWallet="0x7e24c70d0a94b0b8a0ecbc8b26e5898a491af384"
#ZilWallet="zil10qdxdrfz92r25mensa8lgrvxr4dym7nz9a64za"
#EthWallet="0xb5519f097d67044ccf5d11fe4808b0f6fd78d200"
#EtcPool="etc-eu1.nanopool.org:19999"
#eMail="Sav2odin@gmail.com"

