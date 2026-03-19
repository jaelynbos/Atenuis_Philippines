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

do
    sample=$(basename "$file" | cut -d. -f1)
	samtools view -b -F 2308 /scratch/jbos/samfiles/$sample.sam> /scratch/jbos/samfiles/$sample.bam 
done

for file in $(ls -v /scratch/jbos/cladocopium_sam/*.sam)
do
    sample=$(basename "$file" | cut -d. -f1)
	samtools view -b -F 2308 /scratch/jbos/cladocopium_sam/$sample.sam> /scratch/jbos/cladocopium_sam/$sample.bam 
done

for file in $(ls -v /scratch/jbos/samfiles/*.sam)

