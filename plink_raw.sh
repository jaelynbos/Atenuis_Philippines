nk#!/bin/bash

#SBATCH --job-name=bcf_normalize
#SBATCH -o bcf_normalize-%A_%a.out
#SBATCH --mail-user=jbos@ucsc.edu
#SBATCH --mail-type=END
#SBATCH --mem=112G
#SBATCH --time=2:00:00
#SBATCH --partition=lab-mpinsky
#SBATCH --account=pi-mpinsky
#SBATCH --qos=pi-mpinsky

#Fix whatever goofy formatting error Plink introduced so Sequoia can open these files 

cd /scratch/jbos/spp1
plink2 --vcf pruned_snps.vcf --export A --allow-extra-chr --out pruned_snps_raw
	   
cd /scratch/jbos/spp2
plink2 --vcf pruned_snps.vcf --export A --allow-extra-chr --out pruned_snps_raw

cd /scratch/jbos/spp3
plink2 --vcf pruned_snps.vcf --export A --allow-extra-chr --out pruned_snps_raw

cd /scratch/jbos/spp4
plink2 --vcf pruned_snps.vcf --export A --allow-extra-chr --out pruned_snps_raw

cd /scratch/jbos/combined_snps
plink2 --vcf pruned_snps.vcf --export A --allow-extra-chr --out pruned_snps_raw
