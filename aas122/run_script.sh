#!/bin/sh
#PBS -l walltime=12:00:00
#PBS -l select=1:ncpus=1:mem=1gb
module load anaconda3/personal
echo "R is about to run"
R --vanilla < $HOME/HPC_input/aas122_HPC_2022_script_sources_file.R
mv output_* $HOME/HPC_output
echo "R has finished running"
