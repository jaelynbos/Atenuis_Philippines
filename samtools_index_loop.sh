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

module load samtools

ACROPORA_DIR=/scratch/jbos/bam_sorted
CLADOCOPIUM_DIR=/scratch/jbos/cladocopium_bam_sorted

for file in $(ls -v $ACROPORA_DIR/*.bam)

do
    sample=$(basename "$file" | cut -d. -f1)
	samtools index -b $ACROPORA_DIR/$sample.bam $ACROPORA_DIR/$sample.bai
done

for file in $(ls -v $CLADOCOPIUM_DIR/*.bam)

do
    sample=$(basename "$file" | cut -d. -f1)
	samtools index -b $CLADOCOPIUM_DIR/$sample.bam $CLADOCOPIUM_DIR/$sample.bai
done

