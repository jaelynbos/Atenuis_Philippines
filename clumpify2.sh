#!/bin/bash -l

#SBATCH --job-name=clmp_r12
#SBATCH -o clmp_r1r2_-%A_%a.out
#SBATCH --partition=lab-mpinsky
#SBATCH --account=pi-mpinsky
#SBATCH --qos=pi-mpinsky
#SBATCH --mail-user=jbos@ucsc.edu
#SBATCH --mail-type=ALL
#SBATCH --mem=480G

module load java/1.8
module load bbmap/38.90
module load parallel

INDIR=/scratch/jbos/fastp_out
OUTDIR=/scratch/jbos/clmp/
FQPATTERN=r1.fq.gz 
TEMPDIR=/scratch/jbos/temp
THREADS=1   #clumpify uses a ton of ram, be conservative
RAMPERTHREAD=440g  

ulimit -a

mkdir -p $OUTDIR
mkdir -p $TEMPDIR

all_samples=$(ls $INDIR/$FQPATTERN | \
	sed -e 's/r1\.fq\.gz//' -e 's/.*\///g')
all_samples=($all_samples)

sample_name=${all_samples[${SLURM_ARRAY_TASK_ID}]}
echo ${sample_name}

#systemctl status  $PPID  
#systemctl status  $PPID  | head -1 | awk '{print $2}' | xargs systemctl show -p TasksMax
#cat /proc/sys/kernel/threads-max

clumpify.sh \
	in=$INDIR/${sample_name}r1.fq.gz \
	in2=$INDIR/${sample_name}r2.fq.gz \
	out=$OUTDIR/${sample_name}clmp.r1.fq.gz \
	out2=$OUTDIR/${sample_name}clmp.r2.fq.gz \
	groups=auto \
	overwrite=t \
	usetmpdir=t \
	lowcomplexity=t \
	tmpdir=$TEMPDIR \
	deletetemp=t \
	dedupe=t \
	addcount=t \
	subs=2 \
	containment=t \
	consensus=f \
	-Xmx$RAMPERTHREAD
