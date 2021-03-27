#!/bin/bash

#1a
input='syslog.log'
error=$(cat $input | grep 'ERROR')
info=$(cat $input | grep 'INFO')
echo -e "$error\n"
echo -e "$info\n"
c_error=$(grep -c 'ERROR' $input)
c_info=$(grep -c 'INFO' $input)
echo -e "$c_error\n"
echo -e "$c_info\n"

#1b
msg=$(echo "$error" | grep '(?<=ERROR\s)(.*)(?= )')
c_msg=$(echo "$msg" | sort -s | uniq -c )
echo -e "$msg\n"
echo -e "$c_msg\n"
