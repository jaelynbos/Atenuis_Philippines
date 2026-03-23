#!/bin/bash

#SBATCH --job-name=samtools_mapping
#SBATCH -o samtools_mapping-%j.out
#SBATCH --mail-user=jbos@ucsc.edu
#SBATCH --mail-type=ALL
#SBATCH --cpus-per-task=16
#SBATCH --mem=112G
#SBATCH --partition=lab-mpinsky
#SBATCH --qos=pi-mpinsky
#SBATCH --account=pi-mpinsky
#SBATCH --time=24:00:00

#for file in /scratch/jbos/cladocopium_sam/*.sam
#do
#    sample=$(basename "$file" .sam)
#    value=$(samtools flagstat "$file" | awk -F "[(|%]" 'NR == 7 {print $2}')
#    echo -e "${sample}\t${value}" >> cladocopium_mapping.txt
#done

for file in /scratch/jbos/cladocopium_sam/*.sam
do
    sample=$(basename "$file" .sam)
    value=$(samtools flagstat "$file" | awk 'NR == 7 {print $1}')
    echo -e "${sample}\t${value}" >> cladocopium_mapped_number.txt
done

#for file in /scratch/jbos/durusdinium_sam/*.sam
#do
#    sample=$(basename "$file" .sam)
#    value=$(samtools flagstat "$file" | awk -F "[(|%]" 'NR == 7 {print $2}')
#    echo -e "${sample}\t${value}" >> durusdinium_mapping.txt
#done

for file in /scratch/jbos/durusdinium_sam/*.sam
do
    sample=$(basename "$file" .sam)
    value=$(samtools flagstat "$file" | awk 'NR == 7 {print $1}')
    echo -e "${sample}\t${value}" >> durusdinium_mapped_number.txt
done

#for file in /scratch/jbos/symbiodinium_sam/*.sam
#do
#    sample=$(basename "$file" .sam)
#    value=$(samtools flagstat "$file" | awk -F "[(|%]" 'NR == 7 {print $2}')
#    echo -e "${sample}\t${value}" >> symbiodinium_mapping.txt
#done

for file in /scratch/jbos/symbiodinium_sam/*.sam
do
    sample=$(basename "$file" .sam)
    value=$(samtools flagstat "$file" | awk 'NR == 7 {print $1}')
    echo -e "${sample}\t${value}" >> symbiodinium_mapped_number.txt
done

#for file in /scratch/jbos/samfiles/*.sam
#do
#    sample=$(basename "$file" .sam)
#    value=$(samtools flagstat "$file" | awk -F "[(|%]" 'NR == 7 {print $2}')
#    echo -e "${sample}\t${value}" >> acropora_mapping.txt
#done

for file in /scratch/jbos/samfiles/*.sam
do
    sample=$(basename "$file" .sam)
    value=$(samtools flagstat "$file" | awk 'NR == 7 {print $1}')
    echo -e "${sample}\t${value}" >> acropora_mapped_number.txt
done