#!/bin/bash

#SBATCH --job-name=samtools
#SBATCH -o samtools-%A_%a.out
#SBATCH --partition=256x44
#SBATCH --cpus-per-task=16
#SBATCH --mail-user=jbos@ucsc.edu
#SBATCH --mail-type=ALL
#SBATCH --mem=180G
#SBATCH --time=03:00:00

for file in $(ls -v ../../scratch/jbos/test_sams/*.sam)

do
    sample=$(basename "$file" | cut -d. -f1)
	samtools view -b -F 2308 ../../scratch/jbos/samfiles/$sample.sam> ../../scratch/jbos/bamfiles/$sample.bam 
done
