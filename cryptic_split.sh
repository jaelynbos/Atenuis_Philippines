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

INDIR=/scratch/jbos

bcftools view -S taxa1.txt $INDIR/parallel_samples2.vcf > /scratch/jbos/spp1/unfilt_snps.vcf
bcftools view -S taxa2.txt $INDIR/parallel_samples2.vcf > /scratch/jbos/spp2/unfilt_snps.vcf
bcftools view -S taxa3.txt $INDIR/parallel_samples2.vcf > /scratch/jbos/spp3/unfilt_snps.vcf
bcftools view -S taxa4.txt $INDIR/parallel_samples2.vcf > /scratch/jbos/spp4/unfilt_snps.vcf
