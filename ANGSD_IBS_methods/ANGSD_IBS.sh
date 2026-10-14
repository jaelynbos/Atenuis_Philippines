#!/bin/bash

#SBATCH --job-name=ANGSD_IBS
#SBATCH -o ANGSD_IBS.out
#SBATCH --partition=lab-mpinsky
#SBATCH --qos=pi-mpinsky
#SBATCH --account=pi-mpinsky
#SBATCH --cpus-per-task=2
#SBATCH --mail-user=jbos@ucsc.educ
#SBATCH --mail-type=ALL
#SBATCH --mem=264G
#SBATCH --time=240:00:00

module load samtools
module load angsd/0.940

REF=/home/jbos/atenuis_ncbi.fna
BAMLIST=/home/jbos/Philippines_revisions/filtered_acropora_bams.txt
OUTDIR=/scratch/jbos/ANGSD_IBS

mkdir -p $OUTDIR

angsd -bam $BAMLIST \
      -doIBS 1 \
      -doCounts 1 \
      -makeMatrix 1 \
      -doMajorMinor 1 \
      -GL 1 \
      -minMapQ 20 \
      -minQ 25 \
	  -doCov 1 \
      -out $OUTDIR/philippines_acropora