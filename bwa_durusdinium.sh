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

REF=/hb/home/jbos/ncbi/Durusdinium_trenchii.fna
bwa index $REF

for file in $(ls -v /scratch/jbos/repaired2/*.fp2_r1.fq.gz)
do
    sample=$(basename "$file" .fp2_r1.fq.gz)
	rg_string='@RG\tID:'$sample'\.1\tSM:'$sample'\tPL:illumina\tLB:1\tPU:1'
	echo "Sample ID: $sample"
	bwa mem \
		-M \
		-R $rg_string \
		$REF \
		/scratch/jbos/repaired2/$sample.fp2_r1.fq.gz /scratch/jbos/repaired2/$sample.fp2_r2.fq.gz > /scratch/jbos/durusdinium_sam/$sample.sam
done