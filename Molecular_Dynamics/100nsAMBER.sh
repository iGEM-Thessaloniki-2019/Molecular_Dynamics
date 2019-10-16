#!/bin/bash
#SBATCH -J Min-Heat-MD-Amber
#SBATCH -p gpu
#SBATCH -t 10-00:00:00

module load gcc/7.3.0 openmpi/3.1.3 cuda/10.0.130
module load amber

echo 'Minimization of Water and Ions'
date

$AMBERHOME/bin/pmemd.cuda -O -i ./Minimization/min.in -o ./Minimization/min1.out -p TOP_solveted.prmtop -c CORD_solvated.rst7 -r ./Minimization/solute_min.ncrst -ref CORD_solvated.rst7

echo 'Minimization of the whole system'
date

$AMBERHOME/bin/pmemd.cuda -O -i ./SystemMinimization/sysmin.in -o ./SystemMinimization/sysmin1.out -p TOP_solveted.prmtop -c ./Minimization/solute_min.ncrst -r ./SystemMinimization/system_min2.ncrst 

echo 'Heat of Water and Ions'
date

$AMBERHOME/bin/pmemd.cuda -O -i ./Heat/heat.in -o ./Heat/heat1.out -p TOP_solveted.prmtop -c ./Minimization/solute_min.ncrst -r ./Heat/heat1.ncrst -x ./Heat/heat_md.nc -ref ./Minimization/solute_min.ncrst

echo 'MD Equilibration of whole System'
date

$AMBERHOME/bin/pmemd.cuda -O -i ./Equilibration/md.in -o ./Equilibration/md1.out -p TOP_solveted.prmtop -c ./Heat/heat1.ncrst -r ./Equilibration/md1.ncrst -x ./Equilibration/md1.nc

echo 'Molecular Dynamics is finished'
date
