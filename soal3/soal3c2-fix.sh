#!/bin/bash
hari=$(date +"%d-%m-%Y")
kucing=$(ls | grep -e "Kucing.*" | wc -l)
kelinci=$(ls | grep -e "Kelinci.*" | wc -l)
if [[ $kucing == $kelinci ]]
then
mkdir "Kelinci_$hari"
for ((q=1; q<=23; q++))
do
        for ((b=0; b<q; b=b+1))
        do
                if ((q<10))
                then
                wget -O "Koleksi_0$q.jpg" https://loremflickr.com/320/240/bunny -a "Foto.log"
                sama=$(cmp "Koleksi_0$q.jpg" "Koleksi_0$b.jpg")
                akun=$?
                #remove jika sama
                if [ $akun == 0 ]
                then
                        rm "Koleksi_0$q.jpg"
                        let q=$q-1
                        
                fi
                else
                wget -O "Koleksi_$q.jpg" https://loremflickr.com/320/240/bunny -a "Foto.log"
                        if ((b<10))
                        then
                        sama=$(cmp "Koleksi_$q.jpg" "Koleksi_0$b.jpg"  )
                        akun=$?
                        #remove jika sama
                        if [ $akun == 0 ]
                        then
                        rm "Koleksi_$q.jpg"
                        let q=$q-1 
                        fi
                        else 
                        sama=$(cmp "Koleksi_$q.jpg" "Koleksi_$b.jpg"  )
                        akun=$?
                        #remove jika sama
                        if [ $akun == 0 ]
                        then
                        rm "Koleksi_$q.jpg" 
                        let q=$q-1
                        fi
                fi
                fi
        done
done
mv ./Koleksi_* ./Foto.log "./Kelinci_$hari"
else 
mkdir "Kucing_$hari"
for ((q=1; q<=23; q++))
do
        for ((b=0; b<q; b=b+1))
        do
                if ((q<10))
                then
                wget -O "Koleksi_0$q.jpg" https://loremflickr.com/320/240/kitten -a "Foto.log"
                sama=$(cmp "Koleksi_0$q.jpg" "Koleksi_0$b.jpg")
                akun=$?
                #remove jika sama
                if [ $akun == 0 ]
                then
                        rm "Koleksi_0$q.jpg"
                        let q=$q-1
                        
                fi
                else
                wget -O "Koleksi_$q.jpg" https://loremflickr.com/320/240/kitten -a "Foto.log"
                        if ((b<10))
                        then
                        sama=$(cmp "Koleksi_$q.jpg" "Koleksi_0$b.jpg"  )
                        akun=$?
                        #remove jika sama
                        if [ $akun == 0 ]
                        then
                        rm "Koleksi_$q.jpg"
                        let q=$q-1 
                        fi
                        else 
                        sama=$(cmp "Koleksi_$q.jpg" "Koleksi_$b.jpg"  )
                        akun=$?
                        #remove jika sama
                        if [ $akun == 0 ]
                        then
                        rm "Koleksi_$q.jpg" 
                        let q=$q-1
                        fi
                fi
                fi
        done
done
mv ./Koleksi_* ./Foto.log "./Kucing_$hari"
fi