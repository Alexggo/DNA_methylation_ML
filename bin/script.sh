#!/bin/bash

#SBATCH --job-name=Data_format
#SBATCH -o Data_format.sh.out
#SBATCH --nodes=1
#SBATCH -p short-40core
#SBATCH --time=04:00:00

### SET WD
cd /gpfs/projects/BEE690/DNA_methylation_ML/DNA_methylation_ML

### LOAD MODULES
#module load shared
#module load git
conda activate machine_learning



### SCRIPT
python bin/methylation_project_BEE690.py

