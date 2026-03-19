#!/bin/bash

#SBATCH --job-name=clmp_r12_wrap
#SBATCH -o clmp-%A_%a.out
#SBATCH -c 1
#SBATCH --exclusive=user
#SBATCH --mail-user=jbos@ucsc.edu
#SBATCH --mail-type=ALL

#Pass in the maximum number of nodes to use at once
nodes=$4

FQPATTERN=*r1.fq.gz
INDIR=$1
OUTDIR=$2
TMPDIR=$3

SCRIPTPATH=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )

all_samples=$(ls $INDIR/$FQPATTERN | \
	sed -e 's/r1\.fq\.gz//' -e 's/.*\///g')
all_samples=($all_samples)

sbatch --array=0-$((${#all_samples[@]}-1))%${nodes} $SCRIPTPATH/clumpify2.sh ${INDIR} ${OUTDIR} ${TMPDIR} ${FQPATTERN}
