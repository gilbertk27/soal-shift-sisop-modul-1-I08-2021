#!/bin/bash

#1a
grep -oE "(INFO.*)|(ERROR.*)" syslog.log


#1b
grep -oE 'ERROR.*' syslog.log
echo c_err=$(grep -cE 'ERROR' syslog.log) 

#1c
c_user=$(grep -Po '(?<=\()(.*)(?=\))' syslog.log | sort -u)
echo -e "\n$c_user\n"
