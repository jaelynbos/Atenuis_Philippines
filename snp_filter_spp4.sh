#!/bin/bash

#SBATCH --job-name=vcf_filt2
#SBATCH --partition=lab-mpinsky
#SBATCH --qos=pi-mpinsky
#SBATCH --account=pi-mpinsky
#SBATCH -o vcf_filt_spp4-%A_%a.out
#SBATCH --mail-user=jbos@ucsc.edu
#SBATCH --mail-type=END
#SBATCH --mem=112G
#SBATCH --time=2:00:00

#Step 0: Change directory to folder with unfitlered VCF by species

cd /hb/scratch/jbos/spp4_copy

vcftools --vcf unfilt_snps.vcf --minDP 3 --mac 3 --minQ 20 --recode --recode-INFO-all --out unfilt_snps1

#Step 1: Filter SNPs with mean quality score <30
vcftools --vcf unfilt_snps1.recode.vcf --minQ 30 --recode --recode-INFO-all --out snps1

#Step 2: Filter individuals with >99.9% missing data. Some individual samples basically didn't sequence have near 100% missing data. 
vcftools --vcf snps1.recode.vcf --missing-indv --out snps1
awk 'NR >1 && $5 > 0.999 {print $1}' snps1.imiss > snps1_imiss_999
vcftools --vcf snps1.recode.vcf --remove snps1_imiss_999 --recode --recode-INFO-all --out snps2

#Step 3: Filter SNPs missing in >50% of individuals
vcftools --vcf snps2.recode.vcf --max-missing 0.5 --recode --recode-INFO-all --out snps3

#Step 4: Filter individuals missing >98% of data
vcftools --vcf snps3.recode.vcf --missing-indv --out snps3
awk 'NR >1 && $5 > 0.98 {print $1}' snps3.imiss > snps3_imiss_980
vcftools --vcf snps3.recode.vcf --remove snps3_imiss_980 --recode --recode-INFO-all --out snps4

#Step 5: Filter SNPs with mean depth >98th percentile after removing NAs
vcftools --vcf snps4.recode.vcf --out unfilt_depth --depth
vcftools --vcf snps4.recode.vcf --out unfilt_depth --site-mean-depth
vcftools --vcf snps4.recode.vcf --out unfilt_depth --geno-depth
python depth_1stfilt.py
vcftools --vcf snps4.recode.vcf --exclude-positions highdp.txt --recode --recode-INFO-all --out snps5

#Step 6: Filter individuals missing >90% of data
vcftools --vcf snps5.recode.vcf --missing-indv --out snps5
awk 'NR >1 && $5 > 0.90 {print $1}' snps5.imiss > snps5_imiss_900
vcftools --vcf snps5.recode.vcf --remove snps5_imiss_900 --recode --recode-INFO-all --out snps6

#Step 7: Filter SNPs missing in >40% of individuals
vcftools --vcf snps6.recode.vcf --max-missing 0.6 --recode --recode-INFO-all --out snps7

#Step 8: Filter individuals with >85% missing data
vcftools --vcf snps7.recode.vcf --missing-indv --out snps7
awk 'NR >1 && $5 > 0.85 {print $1}' snps7.imiss > snps7_imiss_850
vcftools --vcf snps7.recode.vcf --remove snps7_imiss_850 --recode --recode-INFO-all --out snps8

#Step 9: Filter SNPs missing in >35% of individuals
vcftools --vcf snps8.recode.vcf --max-missing 0.65 --recode --recode-INFO-all --out snps9

#Step 10: Filter individuals with >80% missing data
vcftools --vcf snps9.recode.vcf --missing-indv --out snps9
awk 'NR >1 && $5 > 0.8 {print $1}' snps9.imiss > snps9_imiss_800
vcftools --vcf snps9.recode.vcf --remove snps9_imiss_800 --recode --recode-INFO-all --out snps10

#Step 12: Filter SNPs missing in >39% of individuals
vcftools --vcf snps10.recode.vcf --max-missing 0.70 --recode --recode-INFO-all --out snps11

#Step 13: Filter individuals with >75% missing data
vcftools --vcf snps11.recode.vcf --missing-indv --out snps11
awk 'NR >1 && $5 > 0.75 {print $1}' snps11.imiss > snps11_imiss_750
vcftools --vcf snps11.recode.vcf --remove snps11_imiss_750 --recode --recode-INFO-all --out snps12

#Step 14: Filter SNPs missing in >20% of individuals
vcftools --vcf snps12.recode.vcf --max-missing 0.8 --recode --recode-INFO-all --out snps13

#Step 15: Filter individuals with >75% missing data
vcftools --vcf snps13.recode.vcf --missing-indv --out snps13
awk 'NR >1 && $5 > 0.75 {print $1}' snps13.imiss > snps13_imiss_750
vcftools --vcf snps13.recode.vcf --remove snps13_imiss_750 --recode --recode-INFO-all --out snps14

#Step 16: Filter allele balance
vcffilter -s -f "AB > 0.2 & AB < 0.8 | AB < 0.01"  snps14.recode.vcf > filt_allelebalance.vcf

#Step 17: Quality/depth ratio filter
vcffilter -s -f "QUAL / DP > 0.2" filt_allelebalance.vcf > filt_qualdepth.vcf

#Step 18: Mapping quality filter
vcffilter -s -f "MQM / MQMR > 0.9 & MQM / MQMR < 1.05" filt_qualdepth.vcf > filt_mapqual.vcf

#Step 19: Strand balance filter
vcffilter -f "SAF / SAR > 100 & SRF / SRR > 100 | SAR / SAF > 100 & SRR / SRF > 100" -s filt_mapqual.vcf > filt_strand.vcf

#Step 20: Properly paired status filter
vcffilter -f "PAIRED > 0.05 & PAIREDR > 0.05 & PAIREDR / PAIRED < 1.75 & PAIREDR / PAIRED > 0.25 | PAIRED < 0.05 & PAIREDR < 0.05" -s filt_strand.vcf > filt_paired.vcf

#Step 21: high quality depth filter
cut -f8 filt_paired.vcf | grep -oe "DP=[0-9]*" | sed -s 's/DP=//g' > dp_by_locus.DEPTH
mawk '!/#/' filt_paired.vcf | cut -f1,2,6 > temp.vcf.loci.qual
meandp=$(mawk '{ sum += $1; n++ } END { if (n > 0) print sum / n; }' dp_by_locus.DEPTH)
echo 'mean depth =' 
echo $meandp

cutoff=$(python -c "print(int($meandp+3*($meandp**0.5)))")
echo 'cutoff ='
echo $cutoff

paste temp.vcf.loci.qual dp_by_locus.DEPTH | mawk -v x=$cutoff '$4 > x' | mawk '$3 < 2 * $4' > temp.lowQDloci
vcftools --vcf filt_paired.vcf --exclude-positions temp.lowQDloci --recode --recode-INFO-all --out highqd

#Step 22: Filter individuals with >75% missing data
vcftools --vcf highqd.recode.vcf --missing-indv --out snps16
awk 'NR >1 && $5 > 0.75 {print $1}' snps16.imiss > snps16_imiss_750
vcftools --vcf highqd.recode.vcf --remove snps16_imiss_750 --recode --recode-INFO-all --out snps17

#Step 23:  Filter SNPs missing in >15% of individuals
vcftools --vcf snps17.recode.vcf --max-missing 0.85 --recode --recode-INFO-all --out snps18

#Step 24: Filter out loci with top 2% of mean depths
vcftools --vcf snps18.recode.vcf --out filt_depth --depth
vcftools --vcf snps18.recode.vcf --out filt_depth --site-mean-depth
vcftools --vcf snps18.recode.vcf --out filt_depth --geno-depth

python depth_lastfilt.py
vcftools --vcf snps18.recode.vcf --exclude-positions highdp2.txt --recode --recode-INFO-all --out snps_filtered_depth

#Step 25: Filter individuals with >50% missing data
vcftools --vcf snps_filtered_depth.recode.vcf --missing-indv --out snps19
awk 'NR >1 && $5 > 0.5 {print $1}' snps19.imiss > snps19_imiss_500
vcftools --vcf snps_filtered_depth.recode.vcf --remove snps19_imiss_500 --recode --recode-INFO-all --out snps19
