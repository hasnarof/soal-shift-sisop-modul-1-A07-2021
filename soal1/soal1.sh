#!/bin/bash

# 1a
grep -o -E '(ERROR|INFO).+' syslog.log


# 1b
grep -o -E '(ERROR).+' syslog.log | grep -o -P '(?<=ERROR ).*(?= \()' | sort | uniq -c


# 1c
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
(printf "Error,Count\n"
grep -o -E '(ERROR).+' syslog.log | grep -o -P '(?<=ERROR ).*(?= \()' | sort | uniq -c | sort -nr | sed -e 's/^ *\([0-9]\+\) \(.\+\)/\2,\1/'
) > error_message.csv

# 1e
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