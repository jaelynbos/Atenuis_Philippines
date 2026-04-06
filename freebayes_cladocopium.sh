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

INDIR=/scratch/jbos/cladocopium_bam_sorted
OUTDIR=/scratch/jbos/cladocopium_bam_sorted

samples=$(ls -v $INDIR/*.bam)
 freebayes-parallel <(fasta_generate_regions.py cladocopium_ncbi.fna 80000) 16 --ploidy 1 -f cladocopium_ncbi.fna ${samples} > $OUTDIR/cladocopium_snps.vcf
