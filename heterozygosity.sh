#!/bin/bash

#SBATCH --job-name=heterozygosity
#SBATCH -o heterozygosity-%A_%a.out
#SBATCH --cpus-per-task=2
#SBATCH --mail-user=jbos@ucsc.edu
#SBATCH --mail-type=ALL
#SBATCH --partition=lab-mpinsky
#SBATCH --qos=pi-mpinsky
#SBATCH --account=pi-mpinsky
#SBATCH --mem=24G
#SBATCH --time=2:00:00

module load vcftools

cd /scratch/jbos/spp1_copy/
vcftools  --vcf pruned_snps.vcf --het --out taxa1_het

cd /scratch/jbos/spp2_copy/
vcftools  --vcf pruned_snps.vcf --het --out taxa2_het

cd /scratch/jbos/spp3_copy/
vcftools  --vcf pruned_snps.vcf --het --out taxa3_het

cd /scratch/jbos/spp4_copy/
vcftools  --vcf pruned_snps.vcf --het --out taxa4_het

