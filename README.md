# Molecular_Dynamics

The scripts demonstrated here are written from the members of iGEM Thessaloniki and the outputs are the product of these scripts. They are intendend to produce a 100 ns Molecular Dynamics Simulation, the analysis of the produced trajecory and the calculation of the binding free enrgy  of the complex through the MMGBSA and MMPBSA methods.

### Setting up AMBER 

The user sould not forget to set the AMBERHOME envirometal variable to the installation directory via the commands:
```
$ export AMBERHOME=/directory/of/installation
$ source $AMBERHOME/amber.sh
```
### Preperation of the .pdb file

The 1RAM.pdb file does not contain hydrogens nor ions for the neutralization. Also it contains some molecules that do not exist in our experiments. These molecules are deleted.

```
$ $AMBERHOME/bin/pdb4amber --pdbid 1RAM -o 1RAM_out.pdb -a --reduce --add-missing-atoms
```
The following explains the usage of each flag.
```
	--pdbid 		fetch structure with given pdbid 
	-o 			PDB output file 
	-a keep 		only Amber-compatible residues (in case the pdb contains structes not existing in the experiment. In our case those structures were two DTT molecules 
	--reduce  		Adds hydrogens
	--add-missing-atoms 	Use tleap to add missing atoms
  ```
### Creation of the Complex, Receptor and Ligand .pdb
  
Open the 1RAM_out.pdb with a text editor and erase the waters. 
Save file as complex_no_water.pdb

Open the complex_no_water.pdb with a text editor and erase the protein. 
Save file as DNA.pdb

Open the complex_no_water.pdb with a text editor and erase the DNA. 
Save file as protein_no_water.pdb

### Solute preperation and creation of topology and coordinates files

The solutiona and all topology and coordinates files are created using tleap. Topology and coordinates files are created for the complex, the ligand, the receptor and the solution.

```
$ tleap									# Open tleap
> source leaprc.protein.ff14SB 						# Add a force field designed for proteins the ff14SB force field
> source leaprc.DNA.OL15						# Add a force field designed for DNA the OL15 force field
> source leaprc.water.tip3p						# Add a model designed for water the tip3p model
> PDB = loadpdb 1RAM_out.pdb						# Load the desired structure in pdb format
> CMPLX = loadpdb complex_no_water.pdb				        # Load the desired complex in pdb format
> LIG = loadpdb DNA.pdb							# Load the desired ligand in pdb format
> REC = loadpdb protein_no_water.pdb					# Load the desired receptor in pdb format
> saveamberparm CMPLX CORD_cplx_noWater.prmtop CORD_cplx_noWater.rst7	# Create topology and coordinates files for the complex
> saveamberparm LIG CORD_DNA.prmtop CORD_DNA.rst7			# Create topology and coordinates files for the ligand
> saveamberparm REC CORD_prt_noWater.prmtop CORD_prt_noWater.rst7	# Create topology and coordinates files for the receptor
> addions PDB Na+ 0							# Neutalize with Na+ if the structure is negative, otherwise it does nothing
> addions PDB Cl- 0							# Neutalize with Na+ if the structure is postive, otherwise it does nothing
> solvateBox PDB TIP3PBOX 10 						# Solvate the box with water 	
> saveamberparm PDB TOP_solveted.prmtop CORD_solvated.rst7		# Create topology and coordinates files for the solvent 
> quit									# quit tleap

```


