#!/bin/bash

#SBATCH --job-name=bb_repair
#SBATCH -o bb_repair-%j.out
#SBATCH --mail-user=jbos@ucsc.edu
#SBATCH --mail-type=ALL
#SBATCH --cpus-per-task=16
#SBATCH --mem=180G
#SBATCH --partition=lab-mpinsky
#SBATCH --account=pi-mpinsky
#SBATCH --qos=pi-mpinsky
#SBATCH --time=24:00:00

module load bbtools

INDIR=/scratch/jbos/trim2
OUTDIR=/scratch/jbos/repaired2

for file1 in $(ls -v $INDIR/*.fp2_r1.fq.gz)
do
	name1=$(basename "$file1")
	name1="${name1%.fp2_r1.fq.gz}"
	repair.sh in1=$INDIR/${name1}.fp2_r1.fq.gz in2=$INDIR/${name1}.fp2_r2.fq.gz out1=$OUTDIR/${name1}.fp2_r1.fq.gz out2=$OUTDIR/${name1}.fp2_r2.fq.gz outs=singletons2/${name1}.fq repair
done
