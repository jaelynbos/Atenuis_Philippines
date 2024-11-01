#!/bin/bash

#SBATCH --job-name=fastp
#SBATCH -o fastp_1st_-%j.out
#SBATCH --time=3:00:00
#SBATCH --cpus-per-task=24
#SBATCH --mail-user=jbos@ucsc.edu
#SBATCH --mail-type=ALL
#SBATCH --mem=200G
#SBATCH --partition=256x44

# this script will do all trimming, except 5'
# no merging of overlapping reads
# this is first step in prepping reads for de novo assembly
#enable_lmod
#module load container_env pire_genome_assembly/2021.07.01
# this code is requires if the input files don't live within your own parent directory
# modify "e1garcia" to the user ID where the files are located
#export SINGULARITY_BIND= merged_lanes

INDIR=raw_repaired                
OUTDIR=../../scratch/jbos/fastp_out
FQPATTERN=*.fq.gz
EXTPATTERN=[FR]\.fq\.gz
FWDEXT=F.fq.gz
REVEXT=R.fq.gz
THREADS=12 #1/2 of total threads avail

mkdir $OUTDIR $OUTDIR/failed

ls $INDIR/$FQPATTERN | \
	sed -e "s/$EXTPATTERN//" -e 's/.*\///g' | \
	uniq | \
	parallel --no-notice -j $THREADS \
	fastp \
		--in1 $INDIR/{}$FWDEXT \
		--in2 $INDIR/{}$REVEXT \
		--out1 $OUTDIR/{}r1.fq.gz \
		--out2 $OUTDIR/{}r2.fq.gz \
		--unpaired1 $OUTDIR/failed/{}unprd.fq.gz \
		--unpaired2 $OUTDIR/failed/{}unprd.fq.gz \
		--failed_out $OUTDIR/failed/{}fail.fq.gz \
		-h $OUTDIR/{}fastp.html \
		-j $OUTDIR/{}fastp.json \
		--qualified_quality_phred 20 \
		--unqualified_percent_limit 40 \
		--length_required 33 \
		--low_complexity_filter \
		--complexity_threshold 30 \
		--detect_adapter_for_pe \
		--adapter_sequence=AGATCGGAAGAGCACACGTCTGAACTCCAGTCA \
		--adapter_sequence_r2=AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT \
		--cut_tail \
		--cut_tail_window_size 1 \
		--cut_tail_mean_quality 20 \
		--trim_poly_g \
		--poly_g_min_len 10 \
		--trim_poly_x \
		--dedup\
		--report_title "First Trim 4 De Novo" 
#run multiqc 
#multiqc $OUTDIR -n $OUTDIR/1st_fastp_report --interactive
#multiqc -v -p -ip -f --data-dir --data-format tsv --cl-config "max_table_rows: 3000" --filename 1st_fastp_report --outdir $OUTDIR $OUTDIR
