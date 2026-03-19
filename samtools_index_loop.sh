#!/bin/bash

#SBATCH --job-name=samtools
#SBATCH -o samtools-%j.out
#SBATCH --partition=lab-mpinsky
#SBATCH --account=pi-mpinsky
#SBATCH --qos=pi-mpinsky
#SBATCH --cpus-per-task=16
#SBATCH --mail-user=jbos@ucsc.edu
#SBATCH --mail-type=ALL
#SBATCH --mem=180G
#SBATCH --time=12:00:00

for file in $(ls -v /scratch/jbos/cladocopium_bam_sorted/*.bam)

do
    sample=$(basename "$file" | cut -d. -f1)
	samtools index -b /scratch/jbos/cladocopium_bam_sorted/$sample.bam /scratch/jbos/cladocopium_bam_sorted/$sample.bai
done

for file in $(ls -v /scratch/jbos/bam_sorted/*.bam)

do
    sample=$(basename "$file" | cut -d. -f1)
	samtools index -b /scratch/jbos/bam_sorted/$sample.bam /scratch/jbos/bam_sorted/$sample.bai
done
