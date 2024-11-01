#!/bin/bash

#SBATCH --job-name=bwamem
#SBATCH -o bwa_loop-%j.out
#SBATCH --mail-user=jbos@ucsc.edu
#SBATCH --mail-type=ALL
#SBATCH --cpus-per-task=16
#SBATCH --mem=112G
#SBATCH --partition=128x24
#SBATCH --time=24:00:00

REF=atenuis_ncbi.fna 
bwa index $REF

#for file in $(ls -v fp_repaired/*.clmp.fp2_r2.fq.gz)
#do
#   sample=$(basename "$file" .clmp.fp2_r2.fq.gz)
#	rg_string='@RG\tID:'$sample'\.1\tSM:'$sample'\tPL:illumina\tLB:1\tPU:1'
#	echo "Sample ID: $sample"
#	bwa mem \
#		-M \
#		-R $rg_string \
#		$REF \
#		fp_repaired/$sample.clmp.fp2_r1.fq.gz fp_repaired/$sample.clmp.fp2_r2.fq.gz > fp_repaired/$sample.sam
#done

for file in $(ls -v ../../scratch/jbos/trim2/*.fp2_r1.fq.gz)
do
    sample=$(basename "$file" .fp2_r1.fq.gz)
	rg_string='@RG\tID:'$sample'\.1\tSM:'$sample'\tPL:illumina\tLB:1\tPU:1'
	echo "Sample ID: $sample"
	bwa mem \
		-M \
		-R $rg_string \
		$REF \
		../../scratch/jbos/trim2/$sample.fp2_r1.fq.gz ../../scratch/jbos/trim2/$sample.fp2_r2.fq.gz > ../../scratch/jbos/samfiles/$sample.sam
done