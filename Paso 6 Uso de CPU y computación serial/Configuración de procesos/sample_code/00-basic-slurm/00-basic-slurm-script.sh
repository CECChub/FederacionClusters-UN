#!/bin/bash
#SBATCH --job-name=hostname_test     # Name of the job
#SBATCH --clusters=fisica            # Name of the job
#SBATCH --partition=cpu.cecc         # Partition (queue) name
#SBATCH --nodes=1                    # Number of nodes
#SBATCH --ntasks=1                   # Number of tasks (processes)
#SBATCH --cpus-per-task=1            # Number of CPU cores per task
#SBATCH --mem=1G                     # Memory required per node (1 GB in this case)
#SBATCH --time=00:05:00              # Time limit (HH:MM:SS)
#SBATCH --output=%j_%x.out           # Standard output file (%j will be replaced by job ID)
#SBATCH --error=%j_%x.err            # Standard error file
#SBATCH --mail-type=BEGIN,END,FAIL   # Email notification for job events
#SBATCH --mail-user=your@email.com   # Email address for notifications

# Print some information about the job
echo "Job started at: $(date)"
echo "Running on node: $(hostname)"
echo "Current working directory: $(pwd)"

# Run the hostname command
hostname

# Print job end time
echo "Job finished at: $(date)"
