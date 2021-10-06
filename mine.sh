#!/bin/bash
PathHome=$(dirname "$0")
PathConf="$PathHome."
PathLogs="$PathHome."

#echo "$PathLogs"
# Configurations
if [ -e $PathConf/mine.conf ]
then
	echo "Config: $PathConf/mine.conf"
else
	cp $PathHome/mine.conf $PathConf/mine.conf 
fi
#
source $PathConf/mine.conf

$PathHome/amdcovc-0.4.1.1/amdcovc.sh

echo "$MineName"

if [ "$MineName" == "LolMinerEtc" ]
 then
	################################
	POOL="$EtcPool"
	#etc-eu1.nanopool.org:19999
	WALLET="$EtcWallet.$Worker/$eMail"
	#0x7e24c70d0a94b0b8a0ecbc8b26e5898a491af384.100ratel07/Sav2odin@gmail.com
	################################
	cd "$(dirname "$MinePachBin")"
	echo "MineName:$MineName POOL:$POOL WALLET:$WALLET "
	./lolMiner --algo ETCHASH --pool $POOL --user $WALLET –statsformat speed,poolHr,shares,sharesPerMin,bestShare,power,hrPerWatt,wattPerHr,coreclk,memclk,coreT,juncT,memT,fanPc --logfile $(dirname "$0")/logs --log on
	cd "$(dirname "$0")"
elif [ "$MineName" == "LolMinerEtcZil" ]
 then
	cd "$(dirname "$MinePachBin")"
	echo "$(dirname "$MinePachBin")" "MineName:$MineName POOL:$EtcZilPool WALLET:$WALLET "
	# lolMiner.exe --algo ETCHASH --pool eu.ezil.me:4444 --user ETC_WALLET.ZIL_WALLET.WORKER --ethstratum ETHPROXY timeout 10
	echo "./lolMiner --algo ETCHASH --pool $EtcZilPool --user $EtcWallet.$ZilWallet.$Worker --ethstratum ETHPROXY timeout 10 --logfile $(dirname "$0")/logs --log on"
	./lolMiner --algo ETCHASH --pool $EtcZilPool --user $EtcWallet.$ZilWallet.$Worker --ethstratum ETHPROXY timeout 10 --logfile $(dirname "$0")/logs --log on
	cd "$(dirname "$0")"
 else
 echo "!"
 echo "$MineName" 
fi


#echo "This is the sourced code from the data file."
#Worker="100ratel07"
#MineName="LolMinerEtc"
#MinePachBin="/home/ethereum/Mining/lolMiner/lolMiner"
#EtcWallet="0x7e24c70d0a94b0b8a0ecbc8b26e5898a491af384"
#ZilWallet="zil10qdxdrfz92r25mensa8lgrvxr4dym7nz9a64za"
#EthWallet="0xb5519f097d67044ccf5d11fe4808b0f6fd78d200"
#EtcPool="etc-eu1.nanopool.org:19999"
#eMail="Sav2odin@gmail.com"

