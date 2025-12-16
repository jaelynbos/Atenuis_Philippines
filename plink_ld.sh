#!/bin/bash

#SBATCH --job-name=plink_ld
#SBATCH -o plink_ld-%j.out
#SBATCH --mail-user=jbos@ucsc.edu
#SBATCH --mail-type=ALL
#SBATCH --cpus-per-task=16
#SBATCH --mem=112G
#SBATCH --partition=lab-mpinsky
#SBATCH --qos=pi-mpinsky
#SBATCH --account=pi-mpinsky
#SBATCH --time=24:00:00

cd /hb/scratch/jbos/spp1
plink --vcf snps_filtered_depth.recode.vcf --r2 --ld-window 99999 --ld-window-kb 100000 --ld-window-r2 0 --maf 0.1 --allow-extra-chr --out ld_results

cd /hb/scratch/jbos/spp2
plink --vcf snps_filtered_depth.recode.vcf --r2 --ld-window 99999 --ld-window-kb 100000 --ld-window-r2 0 --maf 0.1 --allow-extra-chr --out ld_results

cd /hb/scratch/jbos/spp3
plink --vcf snps_filtered_depth.recode.vcf --r2 --ld-window 99999 --ld-window-kb 100000 --ld-window-r2 0 --maf 0.1 --allow-extra-chr --out ld_results

cd /hb/scratch/jbos/spp4
plink --vcf snps_filtered_depth.recode.vcf --r2 --ld-window 99999 --ld-window-kb 100000 --ld-window-r2 0 --maf 0.1 --allow-extra-chr --out ld_results