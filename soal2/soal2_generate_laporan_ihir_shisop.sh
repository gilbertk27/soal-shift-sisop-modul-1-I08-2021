#!/bin/bash

echo "The list of customer names in Albuquerque in 2017 includes: "

awk '/Albuquerque/ && $3>="01-01-17" {print $8 " "$9}' Laporan-TokoShiSop.tsv|sort|uniq

echo " "

cut -f 8 Laporan-TokoShiSop.tsv | sort | uniq -c | head -n -1 | tail -n -1 | awk '{print "The type of customer segment with the least sales is " $2 " " $3" with "$1" transactions."}'

