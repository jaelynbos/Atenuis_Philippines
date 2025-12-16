#!/bin/bash

#SBATCH --job-name=admixture_loop
#SBATCH --partition=lab-mpinsky
#SBATCH --qos=pi-mpinsky
#SBATCH --account=pi-mpinsky
#SBATCH -o admixture_loop-%A_%a.out
#SBATCH --mail-user=jbos@ucsc.edu
#SBATCH --mail-type=END
#SBATCH --mem=112G
#SBATCH --time=2:00:00

module load admixture

cd /hb/scratch/jbos/combined_snps
pwd

for i in {1..16}
do
 admixture --cv all_taxa_500bp_int_thinned.bed $i > log${i}.out
done

cd /hb/scratch/jbos/cladocopium
pwd

for i in {1..16}
do
 admixture --cv cladocopium_500bp_int_thinned.bed $i > log${i}.out
done
