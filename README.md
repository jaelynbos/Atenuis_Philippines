# Atenuis_Philippines
This repo uses RADSeq data sequenced from samples of _Acropora cf. tenuis_ corals to explore lanscape genetics in both corals and their algal symbionts.
All code is associated with the mansucript _Contrasting patterns of seascape genetics in_ Acropora cf. tenuis _and their symbiotic algae_ (in prep). 

Genetic data available on NCBI [link to follow]

##Data pre-processing.
Reads are de-multiplexed and merged across lanes. Bioinformatic procssing should be conducted using the following scripts in order:

1. First trim using trim_funcs.sh. Requires: Fastp, Parallel, and Multiqc.
2. Deduplicate using clump_batch.bash to run clumpify.sh. Requires: Clumpify.
3. Second trim using trim_funcs2.sh. Requires: Fastp, Parallel, and Multiqc.
4. Re-pair unpaired reads using repair_2.sh. Requires: BBtools
5. Map genes to _Acropora_ reference using bwa_loop.sh. Requires: BWA
   a. For _Cladocopium_, align to reference using bwa_cladocopium.sh
   b. For _Durusdinium_, align to reference using bwa_cladocopium.sh
   c. For _Symbiodinium_, align to reference using bwa_cladocopium.sh
7. 
