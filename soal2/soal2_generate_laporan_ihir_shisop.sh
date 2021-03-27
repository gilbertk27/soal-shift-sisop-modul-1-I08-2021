#!/bin/bash

#2a

 
#2b
list_name=$(awk '/Albuquerque/ && $3>="01-01-17" {print $8 " "$9}' Laporan-TokoShiSop.tsv | sort | uniq )

#echo ""

#echo -e "The list of customer names in Albuquerque in 2017 includes: \n$list_name\n"

#2c
least_sale=$(cut -f 8 Laporan-TokoShiSop.tsv | sort | uniq -c | head -n -1 | tail -n -1 | awk '{print "The type of customer segment with the least sales is " $2 " " $3" with "$1" transactions."}')

#echo -e "$least_sale\n"

#2d
max_profit=$(cut -f 13,21 Laporan-TokoShiSop.tsv | sort -s | uniq -c | awk 'NR>=2 && p!=$2 {print "The region which has the least total profit is " p " with total profit " s;s=0} {s+=$3*$1} {p=$2}' | head -n 1)

#echo -e "$max_profit\n"

echo -e "The list of customer names in Albuquerque in 2017 includes: \n$list_name\n \n$least_sale\n \n$max_profit\n" > hasil.txt

