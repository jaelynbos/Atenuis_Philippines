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

INDIR_ACROPORA=/scratch/jbos/samfiles
OUTDIR_ACROPORA=/scratch/jbos/bam_sorted

INDIR_CLADOCOPIUM=/scratch/jbos/cladocopium_sam
OUTDIR_CLADOCOPIUM=/scratch/jbos/cladocopium_bam_sorted

for file in $(ls -v $INDIR_ACROPORA/*.bam)

do
    sample=$(basename "$file" | cut -d. -f1)
	samtools sort $INDIR_ACROPORA/$sample.bam -o $OUTDIR_ACROPORA/$sample.bam
done


for file in $(ls -v $INDIR_CLADOCOPIUM/*.bam)

do
    sample=$(basename "$file" | cut -d. -f1)
	samtools sort $INDIR_CLADOCOPIUM/$sample.bam -o $OUTDIR_CLADOCOPIUM/$sample.bam
done


