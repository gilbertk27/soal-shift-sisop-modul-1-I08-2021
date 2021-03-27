#!/bin/bash

#1a
grep -oE "(INFO.*)|(ERROR.*)" syslog.log


#1b
grep -oE 'ERROR.*' syslog.log
echo c_err=$(grep -cE 'ERROR' syslog.log) 

#1c
c_user=$(grep -Po '(?<=\()(.*)(?=\))' syslog.log | sort -u)
echo -e "\n$c_user\n"

#1d
#1d
count_err=$( cat syslog.log | grep 'ERROR' | grep -Po '(?<=ERROR\s)(.*)(?=\s)' | sort | uniq -c)
echo 'Error,Count' > error_message.csv
echo "$count_err" | while read row;
do
error=$(echo $row | cut -d ' ' -f 2-)
count=$(echo $row | cut -d ' ' -f 1)
print="$error,$count"
echo $print >> error_message.csv
done
