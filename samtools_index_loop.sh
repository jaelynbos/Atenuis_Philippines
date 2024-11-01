#!/bin/bash

#SBATCH --job-name=samtools
#SBATCH -o samtools-%A_%a.out
#SBATCH --partition=256x44
#SBATCH --cpus-per-task=16
#SBATCH --mail-user=jbos@ucsc.edu
#SBATCH --mail-type=ALL
#SBATCH --mem=180G
#SBATCH --time=12:00:00

for file in $(ls -v ../../scratch/jbos/bamfiles_sorted/*.bam)

do
    sample=$(basename "$file" | cut -d. -f1)
	samtools index -b ../../scratch/jbos/bamfiles_sorted/$sample.bam ../../scratch/jbos/bamfiles_sorted/$sample.bai
done
