#!/bin/bash

#SBATCH --job-name=bwa_mapping
#SBATCH -o bwa_mapping-%j.out
#SBATCH --mail-user=jbos@ucsc.edu
#SBATCH --mail-type=ALL
#SBATCH --cpus-per-task=16
#SBATCH --mem=112G
#SBATCH --partition=lab-mpinsky
#SBATCH --qos=pi-mpinsky
#SBATCH --account=pi-mpinsky
#SBATCH --time=24:00:00

#Reference genome downloaded from https://www.ncbi.nlm.nih.gov/datasets/genome/GCA_963970005.1/,  GenBank assembly GCA_963970005.1

REF=Durusdinium_trenchii_CCMP2556.fna
bwa index $REF

INDIR=/scratch/jbos/repaired2
OUTDIR=/scratch/jbos/durusdinium_sam

for file in $(ls -v $INDIR/*.fp2_r1.fq.gz)
do
    sample=$(basename "$file" .fp2_r1.fq.gz)
	rg_string='@RG\tID:'$sample'\.1\tSM:'$sample'\tPL:illumina\tLB:1\tPU:1'
	echo "Sample ID: $sample"
	bwa mem \
		-M \
		-R $rg_string \
		$REF \
		$INDIR/$sample.fp2_r1.fq.gz $INDIR/$sample.fp2_r2.fq.gz > $OUTIDR/$sample.sam
done