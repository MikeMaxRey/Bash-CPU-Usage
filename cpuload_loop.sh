#!/bin/bash

trap "calculate_average_and_exit" SIGINT SIGTERM

declare -a cpu_usage_array=()
total=0
count=0

calculate_average_and_exit() {
    average=$((total / count))
    echo "Average CPU Usage: $((average / 100)).$((average % 100))%"
    exit
}

while true; do
    current_time=$(date +"%Y-%m-%d %H:%M:%S")
    cpu_usage=$(awk '
    {
        u=$2+$4; 
        t=$2+$4+$5; 
        if (NR==1){
            u1=u; 
            t1=t;
        } else {
            print int(($2+$4-u1) * 100 / (t-t1));
        }
    }' <(grep 'cpu ' /proc/stat) <(sleep 5; grep 'cpu ' /proc/stat))

    cpu_usage=$((cpu_usage * 100))  # Shift decimal point two places to the right
    echo "Current CPU Usage: $((cpu_usage / 100)).$((cpu_usage % 100))%"
    
    cpu_usage_array+=("$cpu_usage")
    total=$((total + cpu_usage))
    ((count++))

    read -t 1 -n 1 key
    if [[ $key = q ]]; then
        echo "Quitting..."
        calculate_average_and_exit
    fi
done
