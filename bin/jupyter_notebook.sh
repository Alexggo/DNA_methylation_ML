#!/bin/bash


#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH -p short-24core
#SBATCH --time 00:30:00
#SBATCH --job-name jupyter-notebook
#SBATCH --output jupyter-notebook-%J.log

# get tunneling info
XDG_RUNTIME_DIR=""
node=$(hostname -s)
user=$(whoami)
port=1335

# print tunneling instructions to the jupyter-log
echo -e "
Command to create ssh tunnel:
ssh -N -f -L ${port}:${node}:${port} ${user}@login.seawulf.stonybrook.edu

Use a Browser on your local machine to go to:
localhost:${port}"

# load modules or conda environments here
module load jupyter/5.2.4

# Run Jupyter
jupyter notebook --no-browser --port=${port} --ip=${node}
