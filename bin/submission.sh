#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH -p gpu 
#SBATCH --time 08:00:00
#SBATCH --job-name jupyter-notebook
#SBATCH --output jupyter-notebook-%J.log#SBATCH --nodes=1


module load anaconda/3
source activate jupyter

module load tensorflow2-gpu/2.2.0
module load jupyter/5.2.4


srun jupyter nbconvert --to notebook --execute DNA_methylation_analysis_ML.ipynb
