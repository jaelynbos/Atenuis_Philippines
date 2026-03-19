#!/bin/bash
#
#SBATCH --job-name=filesplit
#SBATCH --time=6:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --output=output.%j.filesplit
#SBATCH --partition=lab-mpinsky
#SBATCH --account=pi-mpinsky
#SBATCH --qos=pi-mpinsky
#SBATCH --cpus-per-task=1
#SBATCH --mail-user=jbos@ucsc.edu
#SBATCH --mail-type=ALL
#SBATCH --mem=44G

bcftools view -S taxa1_update.txt /hb/scratch/jbos/parallel_samples2.vcf > /scratch/jbos/spp1_copy/unfilt_snps.vcf
bcftools view -S taxa2_update.txt /hb/scratch/jbos/parallel_samples2.vcf > /scratch/jbos/spp2_copy/unfilt_snps.vcf
bcftools view -S taxa3_update.txt /hb/scratch/jbos/parallel_samples2.vcf > /scratch/jbos/spp3_copy/unfilt_snps.vcf
bcftools view -S taxa4_update.txt /hb/scratch/jbos/parallel_samples2.vcf > /scratch/jbos/spp4_copy/unfilt_snps.vcf
