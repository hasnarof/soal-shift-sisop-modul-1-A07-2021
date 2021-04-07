#!/bin/bash
hari=$(date +"%d-%m-%Y")
mkdir "Kelinci_$hari"
mkdir "Kucing_$hari"


for ((q=1; q<=23; q++))
do
    if((q % 2 == 0))
    then
    for((b=0; b<q; b=b+2))
    do
        wget -O "Koleksi_$q.jpg" https://loremflickr.com/320/240/kitten -a "Foto.log"
        mv ./Koleksi_* "./Kucing_$hari"
        sama=$(cmp "Koleksi_$q.jpg" "Koleksi_$b.jpg")
        akun=$?
        #remove jika sama
        if [ $akun == 0 ]
        then
                rm "Koleksi_$q.jpg"
                let q=$q-1
        fi
    done
    
    else
    for((b=1; b<q; b=b+2))
    do
        wget -O "Koleksi_$q.jpg" https://loremflickr.com/320/240/bunny -a "Foto.log"
        mv ./Koleksi_* "./Kelinci_$hari"
        sama=$(cmp "Koleksi_$q.jpg" "Koleksi_$b.jpg")
        akun=$?
        #remove jika sama
        if [ $akun == 0 ]
        then
                rm "Koleksi_$q.jpg"
                let q=$q-1
        fi
    done
    
    fi
done
