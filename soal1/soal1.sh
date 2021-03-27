#!/bin/bash

# 1a
# menampilkan jenis log (ERROR/INFO), pesan log, dan username pada setiap baris lognya.
grep -o -E '(ERROR|INFO).+' syslog.log


# 1b
# menampilkan semua pesan error yang muncul beserta jumlah kemunculannya.
grep -o -E '(ERROR).+' syslog.log | grep -o -P '(?<=ERROR ).*(?= \()' | sort | uniq -c


# 1c
# menampilkan jumlah kemunculan log ERROR dan INFO untuk setiap user-nya.
declare -A errorCount
declare -A infoCount
declare -A userArray

while read -r line ; do
    if [[ "${line}" =~ \(.+\) ]]; then
    line2=${BASH_REMATCH[0]}
        if [[ "${line2}" =~ [a-z]+ ]]; then
        user=${BASH_REMATCH[0]}
        fi
    fi

    ((userArray[$user]++))

    if [[ "${line}" =~ (ERROR|INFO) ]]; then
        logClass=${BASH_REMATCH[0]}
    fi
    
    if [[ $logClass == "ERROR" ]]; then
        ((errorCount[$user]++))
    else ((infoCount[$user]++))
    fi

done < <(grep -o -E '(ERROR|INFO).+' syslog.log)

for i in "${!userArray[@]}"
do
  printf "$i INFO %d ERROR %d\n" "${infoCount[$i]}" "${errorCount[$i]}"
done

# 1d
# Semua informasi yang didapatkan pada poin b dituliskan ke dalam file error_message.csv dengan
# header Error,Count yang kemudian diikuti oleh daftar pesan error dan jumlah kemunculannya 
# diurutkan berdasarkan jumlah kemunculan pesan error dari yang terbanyak.
(printf "Error,Count\n"
grep -o -E '(ERROR).+' syslog.log | grep -o -P '(?<=ERROR ).*(?= \()' | sort | uniq -c | sort -nr | sed -e 's/^ *\([0-9]\+\) \(.\+\)/\2,\1/'
) > error_message.csv

# 1e
# Semua informasi yang didapatkan pada poin c dituliskan ke dalam file user_statistic.csv dengan 
# header Username,INFO,ERROR diurutkan berdasarkan username secara ascending.
declare -A errorCount
declare -A infoCount
declare -A userArray

while read -r line ; do
    if [[ "${line}" =~ \(.+\) ]]; then
    line2=${BASH_REMATCH[0]}
        if [[ "${line2}" =~ [a-z]+ ]]; then
        user=${BASH_REMATCH[0]}
        fi
    fi

    ((userArray[$user]++))

    if [[ "${line}" =~ (ERROR|INFO) ]]; then
        logClass=${BASH_REMATCH[0]}
    fi
    
    if [[ $logClass == "ERROR" ]]; then
        ((errorCount[$user]++))
    else ((infoCount[$user]++))
    fi

done < <(grep -o -E '(ERROR|INFO).+' syslog.log)

printf "Username,INFO,ERROR\n"
for i in "${!userArray[@]}"
do
  printf "$i,%d,%d \n" "${infoCount[$i]}" "${errorCount[$i]}"
done | sort

# command agar output ditaruh di file csv, test.sh adalah file shell script untuk soal 1e
bash test.sh | tee user_statistic.csv