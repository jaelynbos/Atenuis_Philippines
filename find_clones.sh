#!/bin/bash

#SBATCH --job-name=find_clones
#SBATCH -o find_clones2-%j.out
#SBATCH --mail-user=jbos@ucsc.edu
#SBATCH --mail-type=END
#SBATCH --mem=112G
#SBATCH --time=2:00:00
#SBATCH --partition=lab-mpinsky
#SBATCH --account=pi-mpinsky
#SBATCH --qos=pi-mpinsky

plink2 --vcf /scratch/jbos/spp1/snps19.recode.vcf --make-king-table --king-table-filter 0.354 --allow-extra-chr 

plink2 --vcf /scratch/jbos/spp2/snps19.recode.vcf  --make-king-table --king-table-filter 0.354 --allow-extra-chr

plink2 --vcf /scratch/jbos/spp3/snps19.recode.vcf  --make-king-table --king-table-filter 0.354 --allow-extra-chr 

plink2 --vcf /scratch/jbos/spp4/snps19.recode.vcf  --make-king-table --king-table-filter 0.354 --allow-extra-chr 
