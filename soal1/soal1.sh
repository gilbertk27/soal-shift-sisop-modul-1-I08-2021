#!/bin/bash

#1a
p_error=$(cat syslog.log | grep -Po '(?<=: )(.*)(?<=\))' | sort -u)
echo -e "$p_error \n"

#1b
grep -oE 'ERROR.*' syslog.log
echo c_err=$(grep -cE 'ERROR' syslog.log) 

#1c
c_user=$(grep -Po '(?<=\()(.*)(?=\))' syslog.log | sort -u)
echo -e "\n$c_user\n"

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


#1e
echo 'Username,INFO,ERROR' > user_statistic.csv
for i in $c_user
do
err_c=$(cat syslog.log | grep 'ERROR' | grep -c $i)
info_c=$(cat syslog.log | grep 'INFO' | grep -c $i)
echo "$i,$info_c,$err_c" >> user_statistic.csv
done



#below still error experimental code for 1e

#echo 'Username,INFO,ERROR' > user_statistic_csv 
#c_users=$(grep -Po '(?<=\()(.*)(?=\))' syslog.log | sort -u)

#err_c=$(cat syslog.log | grep 'ERROR' | grep -Po '(?<=\()(.*)(?=\)\K)' )
#echo $err_c
#echo $err_c > err_c.txt 
#err_count=$(cat err_c.txt | uniq -c)
#echo $err_count 
#info_c=$(cat syslog.log | grep 'INFO' | grep -Po '(?<=\()(.*)(?=\))' | uniq -c )
#echo "$i,$info_c,$err_c" >> user_statistic_csv






