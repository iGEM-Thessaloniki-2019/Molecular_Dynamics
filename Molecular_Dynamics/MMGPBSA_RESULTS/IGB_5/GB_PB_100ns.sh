#!/bin/bash  
#SBATCH -J IGB_ISE  
#SBATCH --partition=batch
#SBATCH --cpus-per-task 1
#SBATCH -t 10-00:00:00
#SBATCH -n 40
#SBATCH -N 2
#SBATCH --ntasks-per-node 20
#SBATCH --mail-user charalamm@auth.gr

module load gcc/7.3.0 openmpi/3.1.3
module load amber
source /mnt/apps/prebuilt/amber/18/amber.sh

date

srun $AMBERHOME/bin/MMPBSA.py.MPI -O -i mmgbsa.in -o FINAL_RESULTS_MMPBSA.dat -sp ../TOP_solveted.prmtop -cp ../complex-no-water/TOP_cplx_noWater.prmtop -rp ../protein--no-water-recepotor/TOP_prt_noWater.prmtop -lp ../DNA-ligand/TOP_DNA.prmtop -y ../Equilibration/*.nc

date

