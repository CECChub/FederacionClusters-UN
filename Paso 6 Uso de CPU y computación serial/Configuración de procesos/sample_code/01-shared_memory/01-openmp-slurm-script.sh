#!/bin/bash
#SBATCH --job-name=openmp_sum       # Name of the job
#SBATCH --clusters=fisica           # Partition (queue) name
#SBATCH --partition=cpu.cecc        # Partition (queue) name
#SBATCH --nodes=1                   # Number of nodes
#SBATCH --ntasks=1                  # Number of tasks (processes)
#SBATCH --cpus-per-task=2           # Number of CPU cores per task (this will be number of OpenMP threads)
#SBATCH --mem=10G                    # Memory required per node
#SBATCH --time=00:10:00             # Time limit (HH:MM:SS)
#SBATCH --output=%j_%x.out  # Standard output file
#SBATCH --error=%j_%x.err   # Standard error file

# # Load required modules (modify according to your system)
# module load gcc

# Set OpenMP environment variable to specify number of threads
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK

# Compile the program
g++ -fopenmp -O3 vector_sum.cpp -o vector_sum.x

# Print some information about the job
echo "Job started at: $(date)"
echo "Running on node: $(hostname)"
echo "Number of OpenMP threads: $OMP_NUM_THREADS"

# Run the program
./vector_sum.x

# Print job end time
echo "Job finished at: $(date)"
