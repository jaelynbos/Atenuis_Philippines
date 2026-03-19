#!/bin/bash

#SBATCH --job-name=fst_bootstrap2
#SBATCH -o fst_bootstrap2-%j.out
#SBATCH --mail-user=jbos@ucsc.edu
#SBATCH --mail-type=ALL
#SBATCH --cpus-per-task=2
#SBATCH --mem=24G
#SBATCH --time=72:00:00
#SBATCH --partition=lab-mpinsky
#SBATCH --account=pi-mpinsky
#SBATCH --qos=pi-mpinsky

R
Rscript --vanilla fst_bootstrap_noreplacement.R