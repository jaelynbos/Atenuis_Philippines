#!/bin/bash

#SBATCH --job-name=vcf_filt1
#SBATCH --partition=lab-mpinsky
#SBATCH --qos=pi-mpinsky
#SBATCH --account=pi-mpinsky
#SBATCH -o vcf_filt_spp1%A_%a.out
#SBATCH --mail-user=jbos@ucsc.edu
#SBATCH --mail-type=END
#SBATCH --mem=112G
#SBATCH --time=2:00:00

cd /scratch/jbos/combined_snps
#Filter individuals with >10% missing data
awk 'NR >1 && $5 > 0.1 {print $1}' snps21.imiss > snps21_imiss_100
vcftools --vcf snps_filtered_depth.recode.vcf --remove snps21_imiss_100 --recode --recode-INFO-all --out snps_10per

cd /scratch/jbos/spp1
#Filter individuals with >10% missing data
awk 'NR >1 && $5 > 0.1 {print $1}' snps19.imiss > snps19_imiss_100
vcftools --vcf snps_filtered_depth.recode.vcf --remove snps19_imiss_100 --recode --recode-INFO-all --out snps_10per

cd /scratch/jbos/spp2
#Filter individuals with >10% missing data
awk 'NR >1 && $5 > 0.1 {print $1}' snps19.imiss > snps19_imiss_100
vcftools --vcf snps_filtered_depth.recode.vcf --remove snps19_imiss_100 --recode --recode-INFO-all --out snps_10per

cd /scratch/jbos/spp3
#Filter individuals with >10% missing data
awk 'NR >1 && $5 > 0.1 {print $1}' snps19.imiss > snps19_imiss_100
vcftools --vcf snps_filtered_depth.recode.vcf --remove snps19_imiss_100 --recode --recode-INFO-all --out snps_10per

cd /scratch/jbos/spp4
#Filter individuals with >10% missing data
awk 'NR >1 && $5 > 0.1 {print $1}' snps19.imiss > snps19_imiss_100
vcftools --vcf snps_filtered_depth.recode.vcf --remove snps19_imiss_100 --recode --recode-INFO-all --out snps_10per
