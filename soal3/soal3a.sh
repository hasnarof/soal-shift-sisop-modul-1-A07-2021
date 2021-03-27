#!/bin/bash
for ((h=1; h<=23; h++))
do
        
        wget -O "Koleksi_$h.jpg" https://loremflickr.com/320/240/kitten -a "Foto.log"
        
done

for ((a=1; a<24; a++))
do
        for ((b=a+1; b<24; b++))
        do
                sama=$(cmp "Koleksi_$a.jpg" "Koleksi_$b.jpg")
                akun=$?
                #remove jika sama
                if [ $akun == 0 ]
                then
                        rm Koleksi_$b.jpg
                fi
        done
        
done
