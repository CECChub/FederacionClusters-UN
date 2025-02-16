#!/bin/bash

# Function to create CPU load
cpu_load() {
    while true; do
        echo "$(echo "scale=5000; 4*a(1)" | bc -l)" >/dev/null 2>&1
    done
}

# Alternative load function using pure bash
bash_load() {
    while true; do
        :
    done
}

# Function to spawn processes
spawn_processes() {
    local num_processes=$1
    local duration=$2
    local load_type=$3
    
    echo "Starting $num_processes CPU-intensive processes for $duration seconds"
    
    # Start processes
    for ((i=1; i<=num_processes; i++)); do
        if [ "$load_type" = "bc" ]; then
            cpu_load &
        else
            bash_load &
        fi
        echo "Started process $i with PID $!"
        pids[$i]=$!
    done
    
    # Wait for specified duration
    echo "Running for $duration seconds..."
    sleep $duration
    
    # Kill all spawned processes
    echo "Stopping all processes..."
    for pid in ${pids[*]}; do
        kill $pid
    done
    wait
}

# Parse command line arguments
num_processes=${1:-1}    # Default to 1 process
duration=${2:-60}        # Default to 60 seconds
load_type=${3:-"bash"}   # Default to pure bash implementation

# Print system info
echo "CPU information:"
lscpu | grep "CPU(s):"
echo "Running on: $(hostname)"
echo "Current load: $(uptime)"

# Run the stress test
spawn_processes $num_processes $duration $load_type

echo "Test completed"
