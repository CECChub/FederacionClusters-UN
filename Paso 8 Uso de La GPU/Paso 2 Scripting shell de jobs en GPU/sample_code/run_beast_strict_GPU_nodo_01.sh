#!/bin/bash
#SBATCH --job-name=BEAST_ORFlab_strict   # Name of the job
#SBATCH --cluster=cecc                   # Cluster name
#SBATCH --partition=gpu.cecc             # Partition name
#SBATCH --nodelist=nodo-01               # Node name
#SBATCH --nodes=1                        # Number of nodes
#SBATCH --ntasks-per-node=32             # Number of task (process) per nodes
#SBATCH --gres=gpu:1                     # Generic resources
#SBATCH --mem=32G                        # Memory required per node
#SBATCH --output=/homes/orionsan/eparra/beast_ORFlab_strict_%j.out  # Standard output file
#SBATCH --error=/homes/orionsan/eparra/beast_ORFlab_strict_%j.err    # Standard error file
#SBATCH --export=SCRATCH_DIR=/scratchsan/$SLURM_JOB_ACCOUNT/$SLURM_JOB_USER/$SLURM_JOB_ID

module purge
module load apps/BEAST/1.10.4

cd $SCRATCH_DIR  # --> Siempre colocarlo porque el procesamiento es local al nodo donde se procesa
beast -beagle_opencl -beagle_SSE -threads $SLURM_NTASKS_PER_NODE -beagle_GPU -overwrite ./ORFlab_skyline_strict.xml
