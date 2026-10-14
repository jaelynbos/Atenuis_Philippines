#!/bin/bash

#SBATCH --job-name=snp_pruning
#SBATCH -o snp_pruning-%A_%a.out
#SBATCH --mail-user=jbos@ucsc.edu
#SBATCH --mail-type=END
#SBATCH --mem=112G
#SBATCH --time=2:00:00
#SBATCH --partition=lab-mpinsky
#SBATCH --account=pi-mpinsky
#SBATCH --qos=pi-mpinsky

module load miniconda3
conda activate plink2

cd /scratch/jbos/spp1

plink2 --vcf snps_10per.recode.vcf --allow-extra-chr --set-missing-var-ids @:# --indep-pairwise 50 5 0.5 --out pruned_data10
plink2 --vcf snps_10per.recode.vcf --allow-extra-chr --set-missing-var-ids @:# --extract pruned_data10.prune.in --export vcf-4.2 --out pruned_snps10

cd /scratch/jbos/spp2

plink2 --vcf snps_10per.recode.vcf --allow-extra-chr  --bad-ld--set-missing-var-ids @:# --indep-pairwise 50 5 0.5 --out pruned_data10
plink2 --vcf snps_10per.recode.vcf --allow-extra-chr --set-missing-var-ids @:# --extract pruned_data10.prune.in --export vcf-4.2 --out pruned_snps10

cd /scratch/jbos/spp3

plink2 --vcf snps_10per.recode.vcf --allow-extra-chr --set-missing-var-ids @:# --indep-pairwise 50 5 0.5  --bad-ld --out pruned_data10
plink2 --vcf snps_10per.recode.vcf --allow-extra-chr --set-missing-var-ids @:# --extract pruned_data10.prune.in --export vcf-4.2 --out pruned_snps10

cd /scratch/jbos/spp4

plink2 --vcf snps_10per.recode.vcf --allow-extra-chr --set-missing-var-ids @:# --indep-pairwise 50 5 0.5  --bad-ld --out pruned_data10
plink2 --vcf snps_10per.recode.vcf --allow-extra-chr --set-missing-var-ids @:# --extract pruned_data10.prune.in --export vcf-4.2 --out pruned_snps10

cd /scratch/jbos/cladocopium

plink2 --vcf snps_10per.recode.vcf --allow-extra-chr --set-missing-var-ids @:# --indep-pairwise 50 5 0.5 --out pruned_data10
plink2 --vcf snps_10per.recode.vcf --allow-extra-chr --set-missing-var-ids @:# --extract pruned_data10.prune.in --export vcf-4.2 --out pruned_snps10

cd /scratch/jbos/combined_snps

plink2 --vcf snps_10per.recode.vcf --allow-extra-chr --set-missing-var-ids @:# --indep-pairwise 50 5 0.5 --out pruned_data10
plink2 --vcf snps_10per.recode.vcf --allow-extra-chr --set-missing-var-ids @:# --extract pruned_data10.prune.in --export vcf-4.2 --out pruned_snps10
