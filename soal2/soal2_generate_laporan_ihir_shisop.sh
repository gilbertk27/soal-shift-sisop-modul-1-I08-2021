#!/bin/bash

#2a
awk -F '\t' 'NR>1 {price=$18-$21; percent=($21/price)*100; print $1, percent}' Laporan-TokoShiSop.tsv > filter.txt

#2b
list_name=$(awk 'match($3, "-17") && /Albuquerque/ {print $8 " "$9}' Laporan-TokoShiSop.tsv | sort | uniq )

#echo -e "$list_name\n"

#echo ""

#2c
least_sale=$(cut -f 8 Laporan-TokoShiSop.tsv | sort | uniq -c | head -n -1 | tail -n -1 | awk '{print "The type of customer segment with the least sales is " $2 " " $3" with "$1" transactions."}')

#echo -e "$least_sale\n"

#2d
max_profit=$(cut -f 13,21 Laporan-TokoShiSop.tsv | sort -s | uniq -c | awk 'NR>=2 && p!=$2 {print "The region which has the least total profit is " p " with total profit " s;s=0} {s+=$3*$1} {p=$2}' | head -n 1)

#echo -e "$max_profit\n"

#2e
awk 'BEGIN {max=0;num=0}{if($2>max) max=$2}{if($2==max) num=$1} END {print "The last transaction with the largest Transaction ID is ",num," with a percentage of ",max,"%."}' filter.txt > hasil.txt
 
echo -e "\nThe list of customer names in Albuquerque in 2017 includes: \n$list_name\n \n$least_sale\n \n$max_profit\n" >> hasil.txt

