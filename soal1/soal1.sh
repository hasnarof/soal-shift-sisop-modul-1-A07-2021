#!/bin/bash

# 1a
# https://regexone.com/
# grep -o -E '(ERROR|INFO).+' syslog.log


# 1b
# https://stackoverflow.com/questions/13242469/how-to-use-sed-grep-to-extract-text-between-two-words
# grep -o -E '(ERROR).+' syslog.log | grep -o -P '(?<=ERROR ).*(?= \()' | sort | uniq -c
# grep -o -E '(ERROR).+' syslog.log | grep -o -P '(?<=ERROR ).*(?= \()' | wc -l


# 1c
# https://stackoverflow.com/questions/16317961/how-to-process-each-output-line-in-a-loop
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

    if [[ "${line}" =~ [a-z]+ ]]; then
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