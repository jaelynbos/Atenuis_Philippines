#!/bin/bash

#SBATCH --job-name=shoredist_calc
#SBATCH --partition=lab-mpinsky
#SBATCH -o shoredist_calc-%A_%a.out
#SBATCH --mail-user=jbos@ucsc.edu
#SBATCH --mail-type=END
#SBATCH --mem=96G
#SBATCH --time=06:00:00
#SBATCH --qos=pi-mpinsky    
#SBATCH --account=pi-mpinsky   

python shoredist.py