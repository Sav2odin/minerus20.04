#!/bin/bash
#find /sys/class/drm/card*/device/hwmon/hwmon*/pwm1_enable -exec chmod +w {} \;
#find /sys/class/drm/card*/device/hwmon/hwmon*/pwm1 -exec chmod +w {} \;
find /sys/class/drm/card*/device/hwmon/hwmon*/pwm1_enable -name "*" |while read fname; do
  echo 1 > "$fname"
done
while true
do
find /sys/class/drm/card*/device/hwmon/hwmon* -name "hwmon*" |while read fname; do

cpwm1_enable=`cat "$fname"/pwm1_enable`
declare -i pwm1_enable=$cpwm1_enable
if [ $pwm1_enable -ne 1 ]
 then
  chmod +w "$fname"/pwm1_enable
  echo 1 > "$fname"/pwm1_enable
  cat "$fname"/pwm1_enable
fi
#*****

cterm=`cat "$fname"/temp1_input`
cpwm=`cat "$fname"/pwm1`
declare -i pwm1=$cpwm
declare -i term=$cterm
echo temperature="$cterm", PWM="$cpwm", "$fname"
if test $term -ge $((88*1000))
then
    if [ $pwm1 -lt 250 ]
    then
        chmod +w "$fname"/pwm1
        echo 252 > "$fname"/pwm1
        cat "$fname"/pwm1
    fi
elif test $term -ge $((80*1000))
then
    if [ $pwm1 -lt 231 -o  $pwm1 -gt 238 ]
    then  
        chmod +w "$fname"/pwm1
        echo 238 > "$fname"/pwm1
        cat "$fname"/pwm1
    fi
elif test $term -ge $((75*1000))
then
    if [ $pwm1 -lt 225 -o  $pwm1 -gt 230 ]
    then  
        chmod +w "$fname"/pwm1
        echo 230 > "$fname"/pwm1
        cat "$fname"/pwm1
    fi
elif test $term -ge $((70*1000))
then
    if [ $pwm1 -lt 211 -o  $pwm1 -gt 220 ]
    then  
        chmod +w "$fname"/pwm1
        echo 220 > "$fname"/pwm1
        cat "$fname"/pwm1
    fi
elif test $term -ge $((65*1000))
then
    if [ $pwm1 -lt 181 -o $pwm1 -gt 190 ]
    then  
        chmod +w "$fname"/pwm1
        echo 190 > "$fname"/pwm1
        cat "$fname"/pwm1
    fi
elif test $term -ge $((64*1000))
then
    if [ $pwm1 -lt 176 -o $pwm1 -gt 180 ]
    then  
        chmod +w "$fname"/pwm1
        echo 180 > "$fname"/pwm1
        cat "$fname"/pwm1
    fi
elif test $term -ge $((63*1000))
then
    if [ $pwm1 -lt 171 -o $pwm1 -gt 175 ]
    then  
        chmod +w "$fname"/pwm1
        echo 175 > "$fname"/pwm1
        cat "$fname"/pwm1
    fi
elif test $term -ge $((62*1000))
then
    if [ $pwm1 -lt 168 -o $pwm1 -gt 171 ]
    then  
        chmod +w "$fname"/pwm1
        echo 175 > "$fname"/pwm1
        cat "$fname"/pwm1
    fi
elif test $term -ge $((60*1000))
then
    if [ $pwm1 -lt 161 -o  $pwm1 -gt 168 ]
    then  
        chmod +w "$fname"/pwm1
        echo 170 > "$fname"/pwm1
        cat "$fname"/pwm1
    fi
elif test $term -ge $((59*1000))
then
    if [ $pwm1 -lt 155 -o $pwm1 -gt 160 ]
    then
        chmod +w "$fname"/pwm1
        echo 160 > "$fname"/pwm1
        cat "$fname"/pwm1
    fi
elif test $term -ge $((57*1000))
then
    if [ $pwm1 -lt 151 -o $pwm1 -gt 155 ]
    then
        chmod +w "$fname"/pwm1
        echo 155 > "$fname"/pwm1
        cat "$fname"/pwm1
    fi
elif test $term -ge $((55*1000))
then
    if [ $pwm1 -lt 141 -o $pwm1 -gt 150 ]
    then
        chmod +w "$fname"/pwm1
        echo 140 > "$fname"/pwm1
        cat "$fname"/pwm1
    fi
elif test $term -ge $((50*1000))
then
    if [ $pwm1 -lt 131 -o $pwm1 -gt 140 ]
    then
        chmod +w "$fname"/pwm1
        echo 140 > "$fname"/pwm1
        cat "$fname"/pwm1
    fi
elif test $term -ge $((40*1000))
then
    if [ $pwm1 -lt 121 -o $pwm1 -gt 130 ]
    then  
        chmod +w "$fname"/pwm1
        echo 130 > "$fname"/pwm1
        cat "$fname"/pwm1
    fi
else
    if [ $pwm1 -lt 51 -o $pwm1 -gt 80 ]
    then  
        chmod +w "$fname"/pwm1
        echo 80 > "$fname"/pwm1
        cat "$fname"/pwm1
    fi

fi
done
sleep 5
done	#while
exit 0

