#!/bin/bash

#SBATCH --job-name=vcf_to_bed
#SBATCH --partition=lab-mpinsky
#SBATCH --qos=pi-mpinsky
#SBATCH --account=pi-mpinsky
#SBATCH -o vcf_to_bed-%A_%a.out
#SBATCH --mail-user=jbos@ucsc.edu
#SBATCH --mail-type=END
#SBATCH --mem=32G
#SBATCH --time=2:00:00

module load plink

#Step 0: Change directory to folder with unfitlered VCF by species

cd /hb/scratch/jbos/cladocopium

#This siliness is because ADMIXTURE can't handle letters in chromosome names. For the Cladocopium data the string to sub is CAMXCT

awk -F'\t' 'BEGIN {OFS="\t"} {if ($1 ~ /^CAMXCT/) $1=gensub(/^CAMXCT|\.1$/, "", "g", $1); print}' pruned_snps.vcf > admix.vcf
plink --vcf admix.vcf --make-bed --out admix --allow-extra-chr

#Step 0: Change directory to folder with unfitlered VCF by species

cd /scratch/jbos/combined_snps_copy

#This siliness is because ADMIXTURE can't handle letters in chromosome names. For the Acropora data the string to sub is BLAZ

awk -F'\t' 'BEGIN {OFS="\t"} {if ($1 ~ /^BLAZ/) $1=gensub(/^BLAZ|\.1$/, "", "g", $1); print}' pruned_snps.vcf > admix.vcf
plink --vcf admix.vcf --make-bed --out admix --allow-extra-chr