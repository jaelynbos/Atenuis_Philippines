#!/bin/bash

#SBATCH --job-name=ind_missingness
#SBATCH --partition=lab-mpinsky
#SBATCH --qos=pi-mpinsky
#SBATCH --account=pi-mpinsky
#SBATCH -o ind_missingness.out
#SBATCH --mail-user=jbos@ucsc.edu
#SBATCH --mail-type=END
#SBATCH --mem=112G
#SBATCH --time=2:00:00

#Step 0: Change directory to folder with unfitlered VCF by species
INDIR=/scratch/jbos/combined_snps_copy
OUTDIR=/home/jbos/Philippines_revisions

cd $INDIR

vcftools --vcf parallel_samples2.vcf --minDP 3 --mac 3 --minQ 20 --recode --recode-INFO-all --out unfilt_snps1

#Step 1: Filter SNPs with mean quality score <30
vcftools --vcf unfilt_snps1.recode.vcf --minQ 30 --recode --recode-INFO-all --out snps1

#Step 2: Filter individuals with >99% missing data. Some individual samples basically didn't sequence have near 100% missing data. 
vcftools --vcf snps1.recode.vcf --missing-indv --out $OUTDIR/snps1
awk 'NR >1 && $5 > 0.99 {print $1}' snps1.imiss > $OUTDIR/snps1_imiss_99

vcftools --vcf snps1.recode.vcf --missing-indv --out $OUTDIR/snps1
awk 'NR >1 && $5 > 0.98 {print $1}' snps1.imiss > $OUTDIR/snps1_imiss_98