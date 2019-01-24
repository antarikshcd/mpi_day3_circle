#!/bin/sh
#PBS -r n
#PBS -N pi_2
##PBS -l nodes=1:ppn=2
#PBS -l nodes=2:ppn=1
#PBS -j oe
#PBS -o ping_pong_out.out
#PBS -l walltime=00:10:00

NPROCS=`wc -l < $PBS_NODEFILE` 
echo "NPROCS = " $NPROCS

module add studio
module add mpi/studio
# export PATH=$PATH:/opt/openmpi/1.6.5/sun/bin/mpirun
# change the cd ... below to reach your executable

cd $PBS_O_WORKDIR 

# count=2^0
/opt/openmpi/1.6.5/sun/bin/mpirun -np $NPROCS ./pi.exe