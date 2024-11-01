#!/bin/bash
#
#SBATCH --job-name=fb_parallel
#SBATCH --time=336:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --output=output.%j.fb_parallel
#SBATCH --partition=256x44
#SBATCH --cpus-per-task=36
#SBATCH --mail-user=jbos@ucsc.edu
#SBATCH --mail-type=ALL
#SBATCH --mem=180G

#### SLURM 1 processor FreeBayes test to run for 48 hours.
samples=$(ls -v ../../scratch/jbos/bamfiles_sorted/*.bam)
freebayes-parallel <(fasta_generate_regions.py atenuis_ncbi.fna 80000) 36 -f atenuis_ncbi.fna ${samples[@]} > ../../scratch/jbos/parallel_samples2.vcf