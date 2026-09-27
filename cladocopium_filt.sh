#!/bin/bash

#SBATCH --job-name=vcf_filt3
#SBATCH -o vcf_filt-%A_%a.out
#SBATCH --cpus-per-task=4
#SBATCH --mail-user=jbos@ucsc.edu
#SBATCH --mail-type=ALL
#SBATCH --mem=112G
#SBATCH --time=1:00:00
#SBATCH --account=pi-mpinsky
#SBATCH --qos=pi-mpinsky
#SBATCH --partition=lab-mpinsky


cd /scratch/jbos/cladocopium/

#Step 1: Filter SNPs with mean quality score <30
vcftools --vcf cladocopium_snps.vcf --minQ 30 --recode --recode-INFO-all --out cladocopium_snps1

#Step 2: Filter individuals with >99.9% missing data. Some individual samples basically didn't sequence have near 100% missing data. 
vcftools --vcf cladocopium_snps1.recode.vcf --missing-indv --out snps1
awk 'NR >1 && $5 > 0.999 {print $1}' snps1.imiss > snps1_imiss_999
vcftools --vcf cladocopium_snps1.recode.vcf --remove snps1_imiss_999 --recode --recode-INFO-all --out cladocopium_snps2

#Step 3: Filter SNPs missing in >50% of individuals
vcftools --vcf cladocopium_snps2.recode.vcf --max-missing 0.5 --recode --recode-INFO-all --out cladocopium_snps3

#Step 4: Filter SNPs with mean depth >98th percentile after removing NAs
vcftools --vcf cladocopium_snps3.recode.vcf --out unfilt_depth --depth
vcftools --vcf cladocopium_snps3.recode.vcf --out unfilt_depth --site-mean-depth
vcftools --vcf cladocopium_snps3.recode.vcf --out unfilt_depth --geno-depth

#python depth_1stfilt.py
vcftools --vcf cladocopium_snps3.recode.vcf --exclude-positions highdp.txt --recode --recode-INFO-all --out cladocopium_snps4

#Step 5: Filter individuals with >90% missing data
vcftools --vcf cladocopium_snps4.recode.vcf --missing-indv --out snps4
awk 'NR >1 && $5 > 0.90 {print $1}' snps4.imiss > snps4_imiss_900
vcftools --vcf cladocopium_snps4.recode.vcf --remove snps4_imiss_900 --recode --recode-INFO-all --out cladocopium_snps5

#Step 6: Filter SNPs missing in >40% of individuals
vcftools --vcf cladocopium_snps5.recode.vcf --max-missing 0.6 --recode --recode-INFO-all --out cladocopium_snps6

#Step 7: Filter individuals with >85% missing data
vcftools --vcf cladocopium_snps6.recode.vcf --missing-indv --out snps6
awk 'NR >1 && $5 > 0.85 {print $1}' snps6.imiss > snps6_imiss_850
vcftools --vcf cladocopium_snps6.recode.vcf --remove snps6_imiss_850 --recode --recode-INFO-all --out cladocopium_snps7

#Step 8: Filter SNPs missing in >25% of individuals
vcftools --vcf cladocopium_snps7.recode.vcf --max-missing 0.75 --recode --recode-INFO-all --out cladocopium_snps8

#Step 9: Filter individuals with >70% missing data
vcftools --vcf cladocopium_snps8.recode.vcf --missing-indv --out snps8
awk 'NR >1 && $5 > 0.75 {print $1}' snps8.imiss > snps8_imiss_700
vcftools --vcf cladocopium_snps8.recode.vcf --remove snps8_imiss_700 --recode --recode-INFO-all --out cladocopium_snps9

#Step 13: Mapping quality filter
vcffilter -s -f "MQM / MQMR > 0.9 & MQM / MQMR < 1.05" cladocopium_snps9.recode.vcf > filt_mapqual.vcf

#omit strand balance and properly paired status filters because symbionts are haploid

#Step 16: high quality depth filter
cut -f8 filt_mapqual.vcf | grep -oe "DP=[0-9]*" | sed -s 's/DP=//g' > dp_by_locus.DEPTH
mawk '!/#/' filt_mapqual.vcf | cut -f1,2,6 > temp.vcf.loci.qual
meandp=$(mawk '{ sum += $1; n++ } END { if (n > 0) print sum / n; }' dp_by_locus.DEPTH)
echo 'mean depth =' s
echo $meandp

cutoff=$(python -c "print(int($meandp+3*($meandp**0.5)))")
echo 'cutoff ='
echo $cutoff

paste temp.vcf.loci.qual dp_by_locus.DEPTH | mawk -v x=$cutoff '$4 > x' | mawk '$3 < 2 * $4' > temp.lowQDloci
vcftools --vcf filt_mapqual.vcf --exclude-positions temp.lowQDloci --recode --recode-INFO-all --out highqd

#Step 17: Filter individuals with >70% missing data
vcftools --vcf highqd.recode.vcf --missing-indv --out snps16
awk 'NR >1 && $5 > 0.70 {print $1}' snps16.imiss > snps16_imiss_70
vcftools --vcf highqd.recode.vcf --remove snps16_imiss_70 --recode --recode-INFO-all --out cladocopium_snps17

#Step 18:  Filter SNPs missing in >15% of individuals
vcftools --vcf cladocopium_snps17.recode.vcf --max-missing 0.85 --recode --recode-INFO-all --out cladocopium_snps18

#Step 19: Filter individuals with >50% missing data
vcftools --vcf cladocopium_snps18.recode.vcf --missing-indv --out snps16
awk 'NR >1 && $5 > 0.50 {print $1}' snps16.imiss > snps16_imiss_500

vcftools --vcf cladocopium_snps18.recode.vcf --remove snps16_imiss_500 --recode --recode-INFO-all --out cladocopium_snps19

#Step 20: Filter out loci with top 2% of mean depths
vcftools --vcf cladocopium_snps19.recode.vcf --out filt_depth --depth
vcftools --vcf cladocopium_snps19.recode.vcf --out filt_depth --site-mean-depth
vcftools --vcf cladocopium_snps19.recode.vcf --out filt_depth --geno-depth

python depth_lastfilt.py
vcftools --vcf cladocopium_snps19.recode.vcf --exclude-positions highdp.txt --recode --recode-INFO-all --out snps_filtered_depth

#Step 21: Filter individuals with >50% missing data
vcftools --vcf snps_filtered_depth.recode.vcf --missing-indv --out snps20
awk 'NR >1 && $5 > 0.5 {print $1}' snps20.imiss > snps20_imiss_500
vcftools --vcf snps_filtered_depth.recode.vcf --remove snps20_imiss_500 --recode --recode-INFO-all --out snps20
pwd
