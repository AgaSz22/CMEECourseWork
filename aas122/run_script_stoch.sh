#!/bin/sh
#PBS -lwalltime=00:15:00
#PBS -lselect=1:ncpus=1:mem=1gb
module load anaconda3/personal
echo "R is about to run"
R --vanilla < $HOME/HPC_input_stoch/aas122_HPC_2022_script_sources_stoch_file.R
mv stoch_output* $HOME/HPC_output_stoch
echo "R has finished running"
