#!/bin/bash
# Job name:
#SBATCH --job-name=hello_mpi

# Partition:
#SBATCH --partition=mpi.cecc

# Cluster
#SBATCH --cluster=cecc

# Request one node:
#SBATCH --nodes=2

# Specify one task:
#SBATCH --ntasks-per-node=2

# Number of processors for single task needed for use case (example):
#SBATCH --cpus-per-task=1

# Wall clock limit:
#SBATCH --time=00:05:30

#SBATCH --output=/homes/cybercolombia/esteban/mpi_training_bk/hello_mpi_%j.out  # donde se almacenará la salida estándar (%j es el ID asignado al trabajo)
#SBATCH --error=/homes/cybercolombia/esteban/mpi_training_bk/hello_mpi_%j.err   # donde almacenará la salida del error estándar (%j es el ID asignado al trabajo)
#SBATCH --export=SCRATCH_DIR=/scratch/$SLURM_JOB_ACCOUNT/$SLURM_JOB_USER/$SLURM_JOB_ID

# Command(s) to run (example):
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
module load MPI/openmpi/4.1.1

# MPI con Slurm puede enviarse con srun:
cd $SCRATCH_DIR

srun --mpi=pmix_v4 ./hello_world.exe 2>&1 >> ./hello.log
