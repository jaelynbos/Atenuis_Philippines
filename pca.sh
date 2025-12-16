#!/bin/bash

#SBATCH --job-name=plink_pca
#SBATCH -o plink_pca-%A_%a.out
#SBATCH --cpus-per-task=4
#SBATCH --mail-user=jbos@ucsc.edu
#SBATCH --mail-type=ALL
#SBATCH --mem=112G
#SBATCH --time=12:00:00
#SBATCH --partition=lab-mpinsky
#SBATCH --account=pi-mpinsky
#SBATCH --qos=pi-mpinsky


plink2 --vcf /hb/scratch/jbos/combined_snps/vcf_thinned500bp.recode.vcf --allow-extra-chr --pca --out ../../scratch/jbos/combined_snps/pca_500bp

cd /hb/scratch/jbos/cladocopium
plink2 --vcf vcf_thinned500bp.recode.vcf --allow-extra-chr --pca --out pca_500bp

cd /hb/scratch/jbos/spp1
plink2 --vcf vcf_thinned500bp.recode.vcf --allow-extra-chr --pca --out pca_500bp

cd /hb/scratch/jbos/spp2
plink2 --vcf vcf_thinned500bp.recode.vcf --allow-extra-chr --pca --out pca_500bp

cd /hb/scratch/jbos/spp3
plink2 --vcf vcf_thinned500bp.recode.vcf --allow-extra-chr --pca --out pca_500bp

cd /hb/scratch/jbos/spp4
plink2 --vcf vcf_thinned500bp.recode.vcf --allow-extra-chr --pca --out pca_500bp