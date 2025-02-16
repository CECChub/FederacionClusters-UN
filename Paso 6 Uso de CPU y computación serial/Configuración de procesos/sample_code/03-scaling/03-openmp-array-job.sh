#!/bin/bash
#SBATCH --job-name=openmp_speedup    # Name of the job
#SBATCH --clusters=fisica            # Partition (queue) name
#SBATCH --partition=cpu.cecc         # Partition (queue) name
#SBATCH --nodes=1                    # Number of nodes
#SBATCH --ntasks=1                   # Number of tasks (processes)
#SBATCH --cpus-per-task=8           # Maximum number of CPU cores (adjust based on your system)
#SBATCH --mem=14G                    # Memory required per node
#SBATCH --time=00:10:00              # Time limit (HH:MM:SS)
#SBATCH --array=1-8%1                  # Array job for different thread counts: 1,2,...,8 one at a time
#SBATCH --output=%x_%A_%a.out        # Standard output file
#SBATCH --error=%x_%A_%a.err         # Standard error file

## Load required modules (modify according to your system)
#module load gcc

# Calculate number of threads for this array task
# Will run with 1,2,3, ..., 8 threads
THREADS=$SLURM_ARRAY_TASK_ID

# Make sure we don't exceed the allocated CPUs
if [ $THREADS -gt $SLURM_CPUS_PER_TASK ]; then
    THREADS=$SLURM_CPUS_PER_TASK
fi

# Set OpenMP environment variable
export OMP_NUM_THREADS=$THREADS
echo $OMP_NUM_THREADS

# Compile the program (only needed once, but keeping it here for completeness)
g++ -fopenmp -O3 vector_sum_speedup.cpp -o vector_sum_speedup-$SLURM_ARRAY_TASK_ID.x

# Run the program
./vector_sum_speedup-$SLURM_ARRAY_TASK_ID.x
