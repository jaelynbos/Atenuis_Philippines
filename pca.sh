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

module load miniconda3
conda activate plink2

cd /scratch/jbos/combined_snps
plink2 --vcf pruned_snps_all.vcf --allow-extra-chr --pca --out pca_pruned

cd /scratch/jbos/cladocopium
plink2 --vcf pruned_snps_cladocopium.vcf --allow-extra-chr --pca --out pca_pruned

cd /scratch/jbos/spp1
plink2 --vcf pruned_snps.vcf --allow-extra-chr --pca --out pca_pruned

cd /scratch/jbos/spp2
plink2 --vcf pruned_snps.vcf --allow-extra-chr --pca --out pca_pruned

cd /scratch/jbos/spp3
plink2 --vcf pruned_snps.vcf --allow-extra-chr --pca --out pca_pruned

cd /scratch/jbos/spp4
plink2 --vcf pruned_snps.vcf --allow-extra-chr --pca --out pca_pruned