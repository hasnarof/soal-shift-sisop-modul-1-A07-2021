#!/bin/bash

# 1a
# https://regexone.com/
grep -o -E '(ERROR|INFO).+' syslog.log


# 1b
# https://stackoverflow.com/questions/13242469/how-to-use-sed-grep-to-extract-text-between-two-words
grep -o -E '(ERROR).+' syslog.log | grep -o -P '(?<=ERROR ).*(?= \()' | sort | uniq -c
# grep -o -E '(ERROR).+' syslog.log | grep -o -P '(?<=ERROR ).*(?= \()' | wc -l


# 1c
# https://stackoverflow.com/questions/16317961/how-to-process-each-output-line-in-a-loop
# https://linuxize.com/post/how-to-compare-strings-in-bash/
# https://stackoverflow.com/questions/1898553/return-a-regex-match-in-a-bash-script-instead-of-replacing-it
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
# https://stackoverflow.com/questions/8948975/how-do-you-do-custom-formatting-with-the-uniq-c-option
# https://unix.stackexchange.com/questions/170043/sort-and-count-number-of-occurrence-of-lines
(printf "Error,Count\n"
grep -o -E '(ERROR).+' syslog.log | grep -o -P '(?<=ERROR ).*(?= \()' | sort | uniq -c | sort -nr | sed -e 's/^ *\([0-9]\+\) \(.\+\)/\2,\1/'
) > error_message.csv

# 1e
# https://stackoverflow.com/questions/8217049/bash-associative-array-sorting-by-value
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

# command untuk output ditaruh di file
bash soal1.sh | tee user_statistic.csv