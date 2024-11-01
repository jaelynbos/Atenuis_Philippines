#!/bin/bash
#
#SBATCH --job-name=bamsort
#SBATCH -o bamsort-%A_%a.out
#SBATCH --partition=256x44
#SBATCH --cpus-per-task=16
#SBATCH --mail-user=jbos@ucsc.edu
#SBATCH --mail-type=ALL
#SBATCH --mem=180G
#SBATCH --time=03:00:00

for file in $(ls -v ../../scratch/jbos/bamfiles/*.bam)

do
    sample=$(basename "$file" | cut -d. -f1)
	samtools sort ../../scratch/jbos/bamfiles/$sample.bam -o ../../scratch/jbos/bamfiles_sorted/$sample.bam
done
