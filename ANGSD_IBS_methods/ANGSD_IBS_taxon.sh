#!/bin/bash

#SBATCH --job-name=ANGSD_IBS_taxon
#SBATCH -o ANGSD_IBS_taxon.out
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
BAMLIST1=/home/jbos/Philippines_revisions/Acropora_taxon1.txt
OUTDIR1=/scratch/jbos/ANGSD_Atenuis_1

mkdir -p $OUTDIR1

angsd -bam $BAMLIST1 \
      -doIBS 1 \
      -doCounts 1 \
      -makeMatrix 1 \
      -doMajorMinor 1 \
      -GL 1 \
      -minMapQ 20 \
      -minQ 25 \
	  -doCov 1 \
      -out $OUTDIR1/taxon1

BAMLIST2=/home/jbos/Philippines_revisions/Acropora_taxon2.txt
OUTDIR2=/scratch/jbos/ANGSD_Atenuis_2

mkdir -p $OUTDIR2

angsd -bam $BAMLIST2 \
      -doIBS 1 \
      -doCounts 1 \
      -makeMatrix 1 \
      -doMajorMinor 1 \
      -GL 1 \
      -minMapQ 20 \
      -minQ 25 \
	  -doCov 1 \
      -out $OUTDIR2/taxon2

BAMLIST3=/home/jbos/Philippines_revisions/Acropora_taxon3.txt
OUTDIR3=/scratch/jbos/ANGSD_Atenuis_3

mkdir -p $OUTDIR3

angsd -bam $BAMLIST3 \
      -doIBS 1 \
      -doCounts 1 \
      -makeMatrix 1 \
      -doMajorMinor 1 \
      -GL 1 \
      -minMapQ 20 \
      -minQ 25 \
	  -doCov 1 \
      -out $OUTDIR3/taxon3

BAMLIST4=/home/jbos/Philippines_revisions/Acropora_taxon4.txt
OUTDIR4=/scratch/jbos/ANGSD_Atenuis_4

mkdir -p $OUTDIR4

angsd -bam $BAMLIST4 \
      -doIBS 1 \
      -doCounts 1 \
      -makeMatrix 1 \
      -doMajorMinor 1 \
      -GL 1 \
      -minMapQ 20 \
      -minQ 25 \
	  -doCov 1 \
      -out $OUTDIR4/taxon4

################################################
BAMLIST5=/home/jbos/Philippines_revisions/acro_cebu1.txt
OUTDIR5=/scratch/jbos/ANGSD_Atenuis_1_cebu
mkdir -p $OUTDIR5

angsd -bam $BAMLIST5 \
      -doIBS 1 \
      -doCounts 1 \
      -makeMatrix 1 \
      -doMajorMinor 1 \
      -GL 1 \
      -minMapQ 20 \
      -minQ 25 \
	  -doCov 1 \
      -out $OUTDIR5/taxon1

BAMLIST6=/home/jbos/Philippines_revisions/acro_cebu2.txt
OUTDIR6=/scratch/jbos/ANGSD_Atenuis_2_cebu

mkdir -p $OUTDIR6

angsd -bam $BAMLIST6 \
      -doIBS 1 \
      -doCounts 1 \
      -makeMatrix 1 \
      -doMajorMinor 1 \
      -GL 1 \
      -minMapQ 20 \
      -minQ 25 \
	  -doCov 1 \
      -out $OUTDIR6/taxon2

BAMLIST7=/home/jbos/Philippines_revisions/acro_cebu3.txt
OUTDIR7=/scratch/jbos/ANGSD_Atenuis_3_cebu

mkdir -p $OUTDIR7

angsd -bam $BAMLIST7 \
      -doIBS 1 \
      -doCounts 1 \
      -makeMatrix 1 \
      -doMajorMinor 1 \
      -GL 1 \
      -minMapQ 20 \
      -minQ 25 \
	  -doCov 1 \
      -out $OUTDIR7/taxon3

BAMLIST8=/home/jbos/Philippines_revisions/acro_cebu4.txt
OUTDIR8=/scratch/jbos/ANGSD_Atenuis_4_cebu

mkdir -p $OUTDIR8

angsd -bam $BAMLIST8 \
      -doIBS 1 \
      -doCounts 1 \
      -makeMatrix 1 \
      -doMajorMinor 1 \
      -GL 1 \
      -minMapQ 20 \
      -minQ 25 \
	  -doCov 1 \
      -out $OUTDIR8/taxon4