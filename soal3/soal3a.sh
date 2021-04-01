#!/bin/bash

for ((a=1; a<=24; a=+1))
do
	if [ $a -lt 10 ]
	then
		wget -O Koleksi_0$a https://loremflickr.com/320/240/kitten &>> Foto.log
	else
		wget -O Koleksi_$a https://loremflickr.com/320/240/kitten &>> Foto.log
	fi
done
