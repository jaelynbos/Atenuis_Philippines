#!/bin/bash

#SBATCH --job-name=angsd_prep
#SBATCH -o angsd_prep-%j.out
#SBATCH --partition=lab-mpinsky
#SBATCH --qos=pi-mpinsky
#SBATCH --account=pi-mpinsky
#SBATCH --cpus-per-task=2
#SBATCH --mail-user=jbos@ucsc.edu
#SBATCH --mail-type=ALL
#SBATCH --mem=180G
#SBATCH --time=24:00:00

module load samtools

#Make list of bamfiles
ls /scratch/jbos/bamfiles_sorted/*.bam > /home/jbos/Philippines_revisions/bamlist_acropora.txt

#Samtools index reference
REF=/home/jbos/atenuis_ncbi.fna
samtools faidx $REF

#Make list of contigs
cut -f1 /home/jbos/atenuis_ncbi.fna.fai > /home/jbos/Philippines_revisions/contig_list_Atenuis.txt

#Make list of bamfiles Cladocopium
ls /scratch/jbos/cladocopium_bam_sorted/*.bam > /home/jbos/Philippines_revisions/bamlist_cladocopium.txt

#Samtools index reference
REF=/home/jbos/ncbi/cladocopium_ncbi.fna
samtools faidx $REF

#Make list of contigs
cut -f1 /home/jbos/ncbi/cladocopium_ncbi.fna.fai > /home/jbos/Philippines_revisions/contig_list_Cladocopium.txt

#Make lists of bamfiles for each acropora taxon
awk '{print "/scratch/jbos/bamfiles_sorted/" $0 ".bam"}' /home/jbos/Atenuis_Philippines/other_data/taxa1_dfa.txt > Acropora_taxon1.txt
awk '{print "/scratch/jbos/bamfiles_sorted/" $0 ".bam"}' /home/jbos/Atenuis_Philippines/other_data/taxa2_dfa.txt > Acropora_taxon2.txt
awk '{print "/scratch/jbos/bamfiles_sorted/" $0 ".bam"}' /home/jbos/Atenuis_Philippines/other_data/taxa3_dfa.txt > Acropora_taxon3.txt
awk '{print "/scratch/jbos/bamfiles_sorted/" $0 ".bam"}' /home/jbos/Atenuis_Philippines/other_data/taxa4_dfa.txt > Acropora_taxon4.txt


#Make lists of cladocopium bamfiles for each acropora taxon
awk '{print "/scratch/jbos/cladocopium_bam_sorted/" $0 ".bam"}' /home/jbos/Atenuis_Philippines/other_data/taxa1_dfa.txt > Cladocopium_taxon1.txt
awk '{print "/scratch/jbos/cladocopium_bam_sorted/" $0 ".bam"}' /home/jbos/Atenuis_Philippines/other_data/taxa2_dfa.txt > Cladocopium_taxon2.txt
awk '{print "/scratch/jbos/cladocopium_bam_sorted/" $0 ".bam"}' /home/jbos/Atenuis_Philippines/other_data/taxa3_dfa.txt > Cladocopium_taxon3.txt
awk '{print "/scratch/jbos/cladocopium_bam_sorted/" $0 ".bam"}' /home/jbos/Atenuis_Philippines/other_data/taxa4_dfa.txt > Cladocopium_taxon4.txt