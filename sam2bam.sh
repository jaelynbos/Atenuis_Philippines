#!/bin/bash

#SBATCH --job-name=samtools
#SBATCH -o samtools-%A_%a.out
#SBATCH --partition=lab-mpinsky
#SBATCH --qos=pi-mpinsky
#SBATCH --account=pi-mpinsky
#SBATCH --cpus-per-task=16
#SBATCH --mail-user=jbos@ucsc.edu
#SBATCH --mail-type=ALL
#SBATCH --mem=180G
#SBATCH --time=03:00:00

module load samtools 

DIR_ACROPORA=/scratch/jbos/samfiles
DIR_CLADOCOPIUM=/scratch/jbos/cladocopium_sam

for file in $(ls -v $DIR_ACROPORA/*.sam)
do
    sample=$(basename "$file" | cut -d. -f1)
	samtools view -b -F 2308 $DIR_ACROPORA/$sample.sam> $DIR_ACROPORA/$sample.bam 
done

for file in $(ls -v $DIR_CLADOCOPIUM/*.sam)
do
    sample=$(basename "$file" | cut -d. -f1)
	samtools view -b -F 2308 $DIR_CLADOCOPIUM/$sample.sam> $DIR_CLADOCOPIUM/$sample.bam 
done


