#!/bin/bash

#SBATCH --job-name=bwamem
#SBATCH -o bwa_loop-%j.out
#SBATCH --mail-user=jbos@ucsc.edu
#SBATCH --mail-type=ALL
#SBATCH --cpus-per-task=16
#SBATCH --mem=112G
#SBATCH --partition=lab-mpinsky
#SBATCH --account=pi-mpinsky
#SBATCH --qos=pi-mpinsky
#SBATCH --time=24:00:00

REF=atenuis_ncbi.fna 
bwa index $REF

INDIR=/scratch/jbos/repaired2
OUTDIR=/scratch/jbos/samfiles

for file in $(ls -v $INDIR/*.fp2_r1.fq.gz)
do
    sample=$(basename "$file" .fp2_r1.fq.gz)
	rg_string='@RG\tID:'$sample'\.1\tSM:'$sample'\tPL:illumina\tLB:1\tPU:1'
	echo "Sample ID: $sample"
	bwa mem \
		-M \
		-R $rg_string \
		$REF \
		$INDIR/$sample.fp2_r1.fq.gz $INDIR/$sample.fp2_r2.fq.gz > $OUTDIR/$sample.sam
done