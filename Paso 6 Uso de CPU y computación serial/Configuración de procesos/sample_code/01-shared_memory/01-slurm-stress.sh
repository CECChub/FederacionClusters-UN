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

# Print some information about the job
echo "Job started at: $(date)"
echo "Running on node: $(hostname)"
echo "Number of OpenMP threads: $OMP_NUM_THREADS"

# Run the program
./cpu_stress.sh $OMP_NUM_THREADS 10

# Print job end time
echo "Job finished at: $(date)"
