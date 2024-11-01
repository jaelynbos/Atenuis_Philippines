#!/bin/bash

#SBATCH --job-name=fastp
#SBATCH -o fastp_2nd_-%j.out
#SBATCH --time=3:00:00
#SBATCH --cpus-per-task=12
#SBATCH --mail-user=jbos@ucsc.edu
#SBATCH --mail-type=ALL
#SBATCH --mem=112G
#SBATCH --partition=128x24

# this script will do all trimming, except 5'
# no merging of overlapping reads
# this is first step in prepping reads for de novo assembly
#enable_lmod
#module load container_env pire_genome_assembly/2021.07.01
# this code is requires if the input files don't live within your own parent directory
# modify "e1garcia" to the user ID where the files are located
#export SINGULARITY_BIND= merged_lanes

INDIR=../../scratch/jbos/clumpify               
OUTDIR=../../scratch/jbos/trim2

if [[ -z "$3" ]]; then
	nBP_FRONT_TRIM=0
else
	nBP_FRONT_TRIM=$3
fi

MINLEN=$((33-$nBP_FRONT_TRIM))
if [[ $MINLEN < 33 ]]; then
	MINLEN=33
fi

FQPATTERN=*fq.gz  		#determines files to be trimmed
EXTPATTERN=clmp.r[12]\.fq\.gz  	# pattern match to fq extensions
FWDEXT=clmp.r1.fq.gz
REVEXT=clmp.r2.fq.gz

THREADS=6 #1/2 of total threads avail

ls $INDIR/$FQPATTERN | \
	sed -e "s/$EXTPATTERN//" -e 's/.*\///g' | \
	uniq | \
	parallel --no-notice -j $THREADS \
	fastp \
		--in1 $INDIR/{}$FWDEXT \
		--in2 $INDIR/{}$REVEXT \
		--out1 $OUTDIR/{}fp2_r1.fq.gz \
		--out2 $OUTDIR/{}fp2_r2.fq.gz \
		--unpaired1 $OUTDIR/failed/{}fp2_unprd.fq.gz \
		--unpaired2 $OUTDIR/failed/{}fp2_unprd.fq.gz \
		--failed_out $OUTDIR/failed/{}fp2_fail.fq.gz \
		-h $OUTDIR/{}r1r2_fastp.html \
		-j $OUTDIR/{}r1r2_fastp.json \
		--detect_adapter_for_pe \
		--trim_front1 $nBP_FRONT_TRIM \
		--trim_front2 $nBP_FRONT_TRIM \
		--length_required $MINLEN \
		--cut_front \
		--cut_front_window_size 1 \
		--cut_front_mean_quality 20 \
		--cut_right \
		--cut_right_window_size 10 \
		--cut_right_mean_quality 20 \
		--disable_trim_poly_g \
		--correction \
		--disable_quality_filtering \
		--unqualified_percent_limit 40 \
		--report_title "Second Trim R1R2" 
		
multiqc -v -p -ip -f --data-dir --data-format tsv --cl-config "max_table_rows: 3000" --filename 2nd_fastp_report --outdir $OUTDIR $OUTDIR