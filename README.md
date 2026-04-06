# Atenuis_Philippines
This repo uses RADSeq data sequenced from samples of _Acropora cf. tenuis_ corals to explore lanscape genetics in both corals and their algal symbionts.
All code is associated with the mansucript _Contrasting patterns of seascape genetics in_ Acropora cf. tenuis _and their symbiotic algae_ (in prep). 

The README is organized into four sections: \
A) Data availability \
B) Required software \
C) Bioninformatic pre-processing \
D) Analysis

All pre-processing, mapping, and  analysis was run on the University of California's high performance computing clusters 'Hummingbird' and 'Elkhorn'. 

## Data availability
Raw reads from RAD sequencing are available for download on NCBI at https://www.ncbi.nlm.nih.gov/sra/PRJNA1445311.

Filtered SNPs are additionally available in .vcf format. These are available in the 'vcfs' directory. Many other intermediate datasets required as inputs for producing analysis and figures with .ipynb R scripts can be found in the other_data directory. 

Two metadata files are available in the 'metadat' directory. all_Atenuis_sites.csv contains latitude and longitude coordinates (WGS84) for each sampling site. \
metadata_shoredist.csv includes finer resolution latitude and longitude coordinates extracted from GPS tracks for a subset of the samples (not all sampling days had a working GPS unit available), as well as oceanic depth for a subset of the samples.   

This metadata is additionally available on GEOME (https://n2t.net/ark:/21547/R2686). 

Reference genomes were downloaded from NCBI, at the following links:\
_Acropora tenuis_: https://www.ncbi.nlm.nih.gov/datasets/genome/GCA_014633955.1/, GenBank assembly GCA_014633955.1 \
_Cladocopium goreaui_: https://www.ncbi.nlm.nih.gov/datasets/genome/GCA_947184155.2/, GenBank assembly GCA_947184155.2 \
_Durusdinium trenchii_: https://www.ncbi.nlm.nih.gov/datasets/genome/GCA_963970005.1/, GenBank assembly GCA_963970005.1 \
_Symbiodinium kawagutii_: https://www.ncbi.nlm.nih.gov/datasets/genome/GCA_009767595.1/, GenBank assembly GCA_009767595.1

## Required software
Fastp. https://github.com/opengene/fastp \
Multiqc. https://seqera.io/multiqc/ \
Parallel. https://www.gnu.org/software/parallel/ \
BBtools. https://archive.jgi.doe.gov/data-and-tools/software-tools/bbtools/ \
BWA-mem. https://bio-bwa.sourceforge.net/ \
Samtools. https://github.com/samtools/samtools \
Freebayes. https://github.com/freebayes/freebayes \
Vcftools. https://vcftools.github.io/index.html \
Vcflib. https://github.com/vcflib/vcflib \
Plink2. https://www.cog-genomics.org/plink/2.0/ \
ADMIXTURE. https://dalexander.github.io/admixture/ \
R version 4.4.1 \
Python version 3.9.25. 

## Bioinformatic pre-processing
Reads dowloaded from NCBI are de-multiplexed and merged across lanes. Bioinformatic procssing should be conducted using the following scripts in order:

1.1 First trim using trim_funcs.sh. Requires: Fastp, Parallel, and Multiqc. \
1.2 Deduplicate using clump_batch.bash to run clumpify.sh. Requires: Clumpify (from BBtools). \
1.3 Second trim using trim_funcs2.sh. Requires: Fastp, Parallel, and Multiqc. \
1.4 Re-pair unpaired reads using repair_2.sh. Requires: BBtools. \
1.5 Map genes to _Acropora_ reference using bwa_loop.sh. Requires: BWA. \
&emsp;a. For _Cladocopium_, align to reference using bwa_cladocopium.sh. \
&emsp;b. For _Durusdinium_, align to reference using bwa_cladocopium.sh. \
&emsp;c. For _Symbiodinium_, align to reference using bwa_symbiodinium.sh. \
1.6 Convert samfiles to bamfiles with sam2bam.sh. \
1.7 Sort bamfiles with bamsort.sh. \
1.8 Add indices with samtools_index_loop.sh. \
1.9 Call SNPs for with freebayes_parallel.sh.

## Analysis 

### 2. Analyze genetic variation in _Acropora_
2.1 Filter all _Acropora_ SNPs together with snp_filter_all2.sh (requires depth_1stfilt.py and depth_lastfilt.py). \
2.2 Prune SNPs for linkage disequilibrium with snp_pruning.sh. This produced combined_snps_pruned.vcf. \
2.3 Change chromosome names in vcf in order to run ADMIXTURE with vcf2bed.sh. \
2.4 Run ADMIXTURE with admixture_loop.sh. \
2.5 Compare taxa using DAPC and make figures using PCA_DAPC_ADMIXTURE.ipynb. This produces **Figure 2** and **Supplemental Table 2.**\
2.6 Split samples into cryptic taxa with cryptic_split.sh. \
2.7 Map distribution of taxa across sampling sites with Atenuis_Fig1.R. This produces **Figure 1**.\
2.8 Calculate bootstrapped FSTs across taxa with fst_bootstrap_batch2.sh and fst_bootstrap_noreplacement.R. Check results with fst_Acropora_taxa.ipynb. This produces **Table 1**. \
2.9 Calculate heterozygosity by taxon with heterozygosity.sh. This produces **Supplemental Figure 3**. \
2.10 Check read mapping and depth by taxon with Atenuis_PopGenBasics.ipynb. \
2.11 Filter SNPs separately for each cryptic taxon with: \
&emsp;snp_filter_spp1.sh \
&emsp;snp_filter_spp2.sh \
&emsp;snp_filter_spp3.sh \
&emsp;snp_filter_spp4.sh \
2.12 Prune SNPs for linkage disequilibrium with snp_pruning.sh. This produces all of the individual taxon .vcf files in the 'vcfs' directory (pruned_snps_1.vcf through pruned_snps_4.vcf).

### 3. Isolation by distance in _Acropora_
3.1 Check for possible clones using KING kinship coefficient with find_clones.sh. \
3.2 Analyze isolation by distance with Atenuis_IsolationByDistance.ipynb. This outputs **Figure 3**. \
3.3 Look for relatives with sequoia.ipynb. This is used to produce **Supplemental Table 8**. \
3.4 Map putative parents and offspring with kin_map.R. This is used to create **Figure 4**.

### 4. Compare genomic reads aligning to each symbiont genus
4.1 Calculate distance to shore for every sample with shoredist_calc.sh and shoredist.py. \
4.2 Calculate number of reads mapped to each reference genuis with mappingrate_loop.sh. \
4.3 Compare and make figures with Symbiodiniaceae_ReadMapping.ipynb. This produces **Supplemental Figure 2**, **Supplemental Table 4** and **Supplemental Table 5**.

### 5. Analyze genetic variation in _Cladocopium_
5.1 Change chromosome names in vcf in order to run ADMIXTURE with vcf2bed.sh. \
5.2 Run ADMIXTURE with admixture_loop_cladocopium.sh. \
5.3 Bootstrap across taxa with fst_bootstrap_batch2.sh and fst_bootstrap_noreplacement.R. Visualize results with fst_Cladocopium_taxa.ipynb. This produces **Table 2**.\
5.4 Visualized PCA and ADMIXTURE and check for differences in Cladocopium genotypes between _Acropora_ taxa with Cladocopium.ipynb. This ouptuts **Figure 5**, **Table 3**, **Supplemental Table 1**, and **Supplemental Table 3**. \
5.5 Look for isolation by distance with Cladocopium_IbD.ipynb. This outputs **Figure 6**, **Supplemental Table 6** and **Supplemental Table 7**.
