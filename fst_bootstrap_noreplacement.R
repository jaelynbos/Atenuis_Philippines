.libPaths('/hb/home/jbos/.conda/envs/vcfR')
.libPaths("/hb/home/jbos/.conda/envs/vcfR/lib/R/library")

library(tidyverse)
library(vcfR)
library(hierfstat)
library(adegenet)

vcf<-read.vcfR("/hb/scratch/jbos/cladocopium/vcf_thinned500bp.recode.vcf")

gi <- vcfR2genind(vcf)

taxa1<-read_csv('taxa1_inds.csv',show_col_types = FALSE)
taxa2<-read_csv('taxa2_inds.csv',show_col_types = FALSE)
taxa3<-read_csv('taxa3_inds.csv',show_col_types = FALSE)
taxa4<-read_csv('taxa4_inds.csv',show_col_types = FALSE)

inds<-as.data.frame(matrix(nrow=nrow(gi@tab),ncol=1))
inds$ind<-rownames(gi@tab)
colnames(inds)<-c('taxa','ind')

inds$taxa<-0
inds[inds$ind %in% taxa1$x,1]<-1
inds[inds$ind %in% taxa2$x,1]<-2
inds[inds$ind %in% taxa3$x,1]<-3
inds[inds$ind %in% taxa4$x,1]<-4

gi@pop<-as.factor(inds$taxa)

fst_bootstrap<- function(taxaA,taxaB,genind0,nboot=1000){

#Make genind with only relevant taxa
genind_subset<-genind0[genind0@pop %in% c(taxaA,taxaB)]

boot_fsts<-c()

j=0
while (j < nboot){
	print(j)
	len1<-as.numeric(table(genind_subset@pop)[1])
	print(len1)
	len2<-as.numeric(table(genind_subset@pop)[2])
	print(len2)
	unshuf<-c(rep('A',len1),rep('B',len2))
	shuf<-sample(unshuf,length(unshuf),replace=FALSE)
	samp<-genind_subset
	samp@pop<-as.factor(shuf)
	rownames(samp@tab)<-c(seq(1,nrow(samp@tab),1))
	#Convert to hierfstat
	sample_h<-genind2hierfstat(samp)
	sample_taxa<-pairwise.WCfst(sample_h)	
	boot_fsts<-c(boot_fsts,sample_taxa[2,1])
   j=j+1
}
return(boot_fsts)
}

taxa12<-fst_bootstrap(1,2,gi,1000)
write.csv(taxa12,'cladocopium12_fst_boot.csv')

taxa13<-fst_bootstrap(1,3,gi,1000)
write.csv(taxa13,'cladocopium13_fst_boot.csv')

taxa14<-fst_bootstrap(1,4,gi,1000)
write.csv(taxa14,'cladocopium14_fst_boot.csv')

taxa23<-fst_bootstrap(2,3,gi,1000)
write.csv(taxa23,'cladocopium23_fst_boot.csv')

taxa24<-fst_bootstrap(2,4,gi,1000)
write.csv(taxa24,'cladocopium24_fst_boot.csv')

taxa34<-fst_bootstrap(3,4,gi,1000)
write.csv(taxa34,'cladocopium34_fst_boot.csv')
