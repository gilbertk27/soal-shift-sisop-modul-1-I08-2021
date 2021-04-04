#!/bin/bash

dirloc=/home/xyncz/Downloads/soal3

for ((a=1; a<=23; a=+1))
    do
    if [ $a -lt 10 ]
    then 
        wget -a "$dirloc"/Foto.log "https://loremflickr.com/320/240/kitten" -O "$dirloc"/Koleksi_0"$a".jpg
    else 
    	wget -a "$dirloc"/Foto.log "https://loremflickr.com/320/240/kitten" -O "$dirloc"/Koleksi_"$a".jpg
    fi

done

