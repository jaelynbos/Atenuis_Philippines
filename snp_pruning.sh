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

cd /scratch/jbos/spp1_copy
plink2 --vcf snps19.recode.vcf --allow-extra-chr --set-missing-var-ids @:# --indep-pairwise 50 5 0.5 --out pruned_data
plink2 --vcf snps19.recode.vcf --allow-extra-chr --set-missing-var-ids @:# --extract pruned_data.prune.in --export vcf-4.2 --out pruned_snps

cd /scratch/jbos/spp2_copy
plink2 --vcf snps19.recode.vcf --allow-extra-chr --set-missing-var-ids @:# --indep-pairwise 50 5 0.5 --out pruned_data
plink2 --vcf snps19.recode.vcf --allow-extra-chr --set-missing-var-ids @:# --extract pruned_data.prune.in --export vcf-4.2 --out pruned_snps

cd /scratch/jbos/spp3_copy
plink2 --vcf snps19.recode.vcf --allow-extra-chr --set-missing-var-ids @:# --indep-pairwise 50 5 0.5 --out pruned_data
plink2 --vcf snps19.recode.vcf --allow-extra-chr --set-missing-var-ids @:# --extract pruned_data.prune.in --export vcf-4.2 --out pruned_snps

cd /scratch/jbos/spp4_copy
plink2 --vcf snps19.recode.vcf --allow-extra-chr --set-missing-var-ids @:# --indep-pairwise 50 5 0.5 --out pruned_data
plink2 --vcf snps19.recode.vcf --allow-extra-chr --set-missing-var-ids @:# --extract pruned_data.prune.in --export vcf-4.2 --out pruned_snps

cd /scratch/jbos/combined_snps_copy
plink2 --vcf snps21.recode.vcf --allow-extra-chr --set-missing-var-ids @:# --indep-pairwise 50 5 0.5 --out pruned_data
plink2 --vcf snps21.recode.vcf --allow-extra-chr --set-missing-var-ids @:# --extract pruned_data.prune.in --export vcf-4.2 --out pruned_snps

cd /scratch/jbos/cladocopium
plink2 --vcf snps20.recode.vcf --allow-extra-chr --set-missing-var-ids @:# --indep-pairwise 50 5 0.5 --out pruned_data
plink2 --vcf snps20.recode.vcf --allow-extra-chr --set-missing-var-ids @:# --extract pruned_data.prune.in --export vcf-4.2 --out pruned_snps
