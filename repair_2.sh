#!/bin/bash

#SBATCH --job-name=bb_repair
#SBATCH -o bb_repair-%j.out
#SBATCH --mail-user=jbos@ucsc.edu
#SBATCH --mail-type=ALL
#SBATCH --cpus-per-task=16
#SBATCH --mem=180G
#SBATCH --partition=1024x28
#SBATCH --time=24:00:00

#Required software: bbtools

for file1 in $(ls -v ../../scratch/jbos/trim2/*.fp2_r1.fq.gz)
do
	name1=$(basename "$file1")
	name1="${name1%.fp2_r1.fq.gz}"
	repair.sh in1=../../scratch/jbos/trim2/${name1}.fp2_r1.fq.gz in2=../../scratch/jbos/trim2/${name1}.fp2_r2.fq.gz out1=repaired2/${name1}.fp2_r1.fq.gz out2=repaired2/${name1}.fp2_r2.fq.gz outs=singletons2/${name1}.fq repair
done
