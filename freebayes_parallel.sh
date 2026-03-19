#!/bin/bash
#
#SBATCH --job-name=fb_parallel
#SBATCH --time=336:00:00
#SBATCH --nodes=1
#SBATCH --output=output.%j.fb_parallel
#SBATCH --partition=lab-mpinsky
#SBATCH --cpus-per-task=16
#SBATCH --mail-user=jbos@ucsc.edu
#SBATCH --mail-type=ALL
#SBATCH --mem=800G
#SBATCH --qos=pi-mpinsky
#SBATCH --account=pi-mpinsky

export LANGUAGE=C
export LC_ALL=C
export LANG=C

samples=$(ls -v /scratch/jbos/bamfiles_sorted/*.bam)
 freebayes-parallel <(fasta_generate_regions.py atenuis_ncbi.fna 80000) 16 --ploidy 2 -f atenuis_ncbi.fna ${samples} > /scratch/jbos/combined_snps/parallel_samples2.vcf
 
samples=$(ls -v /scratch/jbos/cladocopium_bam_sorted/*.bam)
 freebayes-parallel <(fasta_generate_regions.py cladocopium_ncbi.fna 80000) 16 --ploidy 1 -f cladocopium_ncbi.fna ${samples} > /scratch/jbos/cladocopium/cladocopium_snps.vcf
