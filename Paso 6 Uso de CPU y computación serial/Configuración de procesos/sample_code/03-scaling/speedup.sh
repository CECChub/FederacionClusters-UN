#!/bin/bash

echo "Extracting data"
cat *err | grep -v line | sort  > data.txt

echo "Computing metrics ..."
awk -F',' '{
    if (NR == 1) {
        serial_time = $2; 
    } else {
        speedup = serial_time / $2;
        efficiency = speedup / $1;
        printf "serial:%.2f, time=%.2f, Threads: %d, Speedup: %.2f, Efficiency: %.2f%%\n", serial_time, $2, $1, speedup, efficiency * 100;
    }
}' data.txt 
