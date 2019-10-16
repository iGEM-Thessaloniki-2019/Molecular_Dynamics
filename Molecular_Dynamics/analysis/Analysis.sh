#!/bin/bash
#SBATCH -J 100nsAnalysis
#SBATCH  --cpus-per-task 20
#SBATCH -t 10-00:00:00

module load gcc/7.3.0 openmpi/3.1.3
module load amber
source /mnt/apps/prebuilt/amber/18/amber.sh

date

$AMBERHOME/bin/process_mdout.perl ../Heat/heat1.out ../Equilibration/md1.out 

date
