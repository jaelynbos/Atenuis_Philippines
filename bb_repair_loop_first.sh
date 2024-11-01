#!/bin/bash

#SBATCH --job-name=bb_repair
#SBATCH -o bb_repair-%j.out
#SBATCH --mail-user=jbos@ucsc.edu
#SBATCH --mail-type=ALL
#SBATCH --cpus-per-task=16
#SBATCH --mem=180G
#SBATCH --partition=256x44
#SBATCH --time=24:00:00

#Required software: bbtools

for file1 in $(ls -v merged_lanes/*.F.fq.gz)
do
	name1=$(basename "$file1")
	name1="${name1%.F.fq.gz}"
	repair.sh in1=merged_lanes/${name1}.F.fq.gz in2=merged_lanes/${name1}.R.fq.gz out1=raw_repaired/${name1}.F.fq.gz out2=raw_repaired/${name1}.R.fq.gz outs=raw_singletons/${name1}.fq repair
done