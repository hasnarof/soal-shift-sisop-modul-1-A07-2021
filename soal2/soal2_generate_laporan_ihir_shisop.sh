#!/bin/bash

(# 2. a.
# Transaksi terakhir dengan profit percentage terbesar 

awk -F"\t" -v max=0 'NR>1{    
    if($21/($18-$21)*100>=max){
        id=$1; max=$21/($18-$21)*100
        }
    }
END{
    printf "Transaksi terakhir dengan profit percentage terbesar yaitu %d dengan persentase %.2f%.\n\n", id, max
    }' Laporan-TokoShiSop.tsv

# 2. b.
# Daftar nama customer di Albuquerque pada tahun 2017

echo "Daftar nama customer di Albuquerque pada tahun 2017 antara lain :"
awk -F'\t' 'NR>1{ 
    if($10 ~ /Albuquerque/) print $7,$3,$10
    }' Laporan-TokoShiSop.tsv | uniq |
    awk '{split($0,tgl,"-"); if(tgl[3] ~ /17/) print $1,$2}'

printf "\n"

# 2. c.
# Tipe segmen customer yang penjualannya paling sedikit dan total transaksinya.

awk -F'\t' 'NR>1{
    segmen[$8]++
    }
END{ 
    for (s in segmen) print s, segmen[s]
    }' Laporan-TokoShiSop.tsv | sort -g -k 2 | head -n 1 | 
    awk '{split($0,segmen," "); 
    printf "Tipe segmen customer yang penjualannya paling sedikit adalah %s %s dengan %d transaksi.\n\n", 
    segmen[1],segmen[2],segmen[3]}'

# 2. d.
# Wilayah bagian (region) yang memiliki total keuntungan (profit) yang
# paling sedikit dan total keuntungannya

awk -F'\t' 'NR>1{
    region[$13]+=$21
    }
END{
    for (r in region) print r,region[r]
    }' Laporan-TokoShiSop.tsv | sort -g -k 2 | head -n 1 |
    awk '{split($0,region," "); printf "Wilayah bagian (region) yang memiliki total keuntungan (profit) yang paling sedikit adalah %s dengan total keuntungan %.2f.\n", region[1],region[2]}') > hasil.txt