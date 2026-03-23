# Atenuis_Philippines
This repo uses RADSeq data sequenced from samples of _Acropora cf. tenuis_ corals to explore lanscape genetics in both corals and their algal symbionts.
All code is associated with the mansucript _Contrasting patterns of seascape genetics in_ Acropora cf. tenuis _and their symbiotic algae_ (in prep). 

Genetic data available on NCBI [link to follow]

## Data pre-processing
Reads are de-multiplexed and merged across lanes. Bioinformatic procssing should be conducted using the following scripts in order:

1. First trim using trim_funcs.sh. Requires: Fastp, Parallel, and Multiqc.
2. Deduplicate using clump_batch.bash to run clumpify.sh. Requires: Clumpify.
3. Second trim using trim_funcs2.sh. Requires: Fastp, Parallel, and Multiqc.
4. Re-pair unpaired reads using repair_2.sh. Requires: BBtools
5. Map genes to _Acropora_ reference using bwa_loop.sh. Requires: BWA
   a. For _Cladocopium_, align to reference using bwa_cladocopium.sh
   b. For _Durusdinium_, align to reference using bwa_cladocopium.sh
   c. For _Symbiodinium_, align to reference using bwa_symbiodinium.sh
7. Convert samfiles to bamfiles with sam2bam.sh
8. Sort bamfiles with bamsort.sh
9. Add indices with samtools_index_loop.sh
10. Call SNPs with freebayes_parallel.sh
    
## Compare read percentages of different symbionts
Calculate distance to shore for every sample with shoredist_calc.sh and shoredist.py

Calculate number of reads mapped to each reference genuis with mappingrate_loop.sh

Then compare and make figures with Symbiodiniaceae_ReadMapping.ipynb

## Analyze genetic variation in _Acropora_

Filter all SNPs together with snp_filter_all2.sh (requires depth_1stfilt.py and depth_lastfilt.py). 
Prune SNPs for linkage disequilibrium with snp_pruning.sh

Change chromosome names in vcf in order to run ADMIXTURE with vcf2bed.sh
Run ADMIXTURE with admixture_loop.sh

Compare taxa using DAPC and make figures using PCA_DAPC_ADMIXTURE.ipynb

Split into cryptic taxa with cryptic_split.sh

Bootstrap across taxa with fst_bootstrap_batch2.sh and fst_bootstrap_noreplacement.R

Calculate heterozygosity by taxon with heterozygosity.sh

Check read mapping and depth by taxon with Atenuis_PopGenBasics.ipynb 

Filter SNPs separately for each cryptic taxon with 
snp_filter_spp1.sh
snp_filter_spp2.sh
snp_filter_spp3.sh
snp_filter_spp4.sh

Prune SNPs for linkage disequilibrium with snp_pruning.sh

## Isolation by distance in _Acropora_
Check for possible clones using KING kinship coefficient with find_clones.sh

Analyze isolation by distance with Atenuis_IsolationByDistance.ipynb

Look for relatives with sequoia.ipynb

## Analyze genetic variation in _Cladocopium_
Change chromosome names in vcf in order to run ADMIXTURE with vcf2bed.sh
Run ADMIXTURE with admixture_loop.sh

Bootstrap across taxa with fst_bootstrap_batch2.sh and fst_bootstrap_noreplacement.R

Make figures and look for differences between _Acropora_ taxa with Cladocopium.ipynb

Look for isolation by distance with Cladocopium_IbD.ipynb
