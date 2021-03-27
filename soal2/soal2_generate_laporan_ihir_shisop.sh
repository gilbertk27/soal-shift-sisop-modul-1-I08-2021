#!/bin/bash
#awk '
#{

#2b
echo "The list of customer names in Albuquerque in 2017 includes: "

awk '/Albuquerque/ && $3>="01-01-17" {print $8 " "$9}' Laporan-TokoShiSop.tsv|sort|uniq

echo " "

#2c
cut -f 8 Laporan-TokoShiSop.tsv | sort | uniq -c | head -n -1 | tail -n -1 | awk '{print "The type of customer segment with the least sales is " $2 " " $3" with "$1" transactions."}'

echo " "

#2d
cut -f 13,21 Laporan-TokoShiSop.tsv | sort -s | uniq -c | awk 'NR>=2 && p!=$2 {print "The region which has the least total profit is " p " with total profit " s;s=0} {s+=$3*$1} {p=$2}' | head -n 1

#}
#'/home/xyncz/Documents/GitHub/soal-shift-sisop-modul-1-I08-2021/soal2/Laporan-TokoShiSop.tsv > hasil.txt
