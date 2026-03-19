#!/bin/bash
#
#SBATCH --job-name=bamsort
#SBATCH -o bamsort-%A_%a.out
#SBATCH --partition=lab-mpinsky
#SBATCH --qos=pi-mpinsky
#SBATCH --account=pi-mpinsky
#SBATCH --cpus-per-task=16
#SBATCH --mail-user=jbos@ucsc.edu
#SBATCH --mail-type=ALL
#SBATCH --mem=180G
#SBATCH --time=03:00:00

mkdir /scratch/jbos/cladocopium_bam_sorted/

for file in $(ls -v /scratch/jbos/cladocopium_sam/*.bam)

do
    sample=$(basename "$file" | cut -d. -f1)
	samtools sort /scratch/jbos/cladocopium_sam/$sample.bam -o /scratch/jbos/cladocopium_bam_sorted/$sample.bam
done

mkdir /scratch/jbos/bam_sorted/

for file in $(ls -v /scratch/jbos/samfiles/*.bam)

do
    sample=$(basename "$file" | cut -d. -f1)
	samtools sort /scratch/jbos/samfiles/$sample.bam -o /scratch/jbos/bam_sorted/$sample.bam
done
