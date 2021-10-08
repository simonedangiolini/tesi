path_to_gene_count<-$1
condition1<-$2
condition2<-$3
path_to_file_with_protein_coding_gene_name_in_references_genome<-$4
path_to_output_file<-$5


directory <- path_to_gene_count
sampleFiles<-grep("condition1|condition2",list.files(directory),value=TRUE)   #select the sample of the condition of interest
condition<- c("condition1","condition1","condition2","condition2")  #assign the right condition to every sample
sampleTable<- data.frame(sampleName=sampleFiles,)
                         fileName=sampleFiles,
                         condition= condition)
sampleTable$condition <- factor(sampleTable$condition)
library("DESeq2", warn.conflicts = FALSE)
ddsHTSeq <- DESeqDataSetFromHTSeqCount(sampleTable = sampleTable,
                                       directory = directory,
                                       design = ~condition)
keep <- rowSums(counts(ddsHTSeq)) >= 10                     #eliminate all the genes that have gene counts <10 across the samples 
ddsHTSeq <- ddsHTSeq[keep,]
ddsHTSeq<-DESeq(ddsHTSeq)
results(ddsHTSeq)
res <- results(ddsHTSeq, contrast=c("condition",condition1,condition2))
deseq2ResA <- as.data.frame(res)
protein_cod<-read.table("path_to_file_with_protein_coding_gene_name_in_references_genome", fill = TRUE) #select all protein coding genes name from another file
deseq2ResAFinal<-deseq2ResA
deseq2ResAFinal<-deseq2ResAFinal[intersect(rownames(deseq2ResAFinal),protein_cod$V2),]  #eliminate all the file that are not protein coding genes
deseq2ResAFinal$diffexpressed <- "NO"
deseq2ResAFinal$diffexpressed[deseq2ResAFinal$log2FoldChange > 0 & deseq2ResAFinal$padj < 0.05] <- "UP"
deseq2ResAFinal$diffexpressed[deseq2ResAFinal$log2FoldChange < 0 & deseq2ResAFinal$padj < 0.05] <- "DOWN" 
DEG<-subset(deseq2ResAFinal, diffexpressed=="DOWN" | diffexpressed=="UP")   #leave in DEG just the genes that are differented express across the groups
conts<-counts(ddsHTSeq)
conts<-as.data.frame(counts)                                        #here we have the counts of each gene for each sample 
counts_condition1<-subset(conte[,1:number_of_sample_condition_1])    #separate the counts for every conditions
counts_condition2<-subset(conte[,(number_of_sample_condition_1+1):(number_of_sample_condition_2]+(number_of_sample_condition_1))
counts_condition1<-countscondition1[row.names(countscondition1) %in% row.names(DEG),]    #filter the counts and leave just those refer to DEG
counts_condition2<-countscondition2[row.names(countscondition2) %in% row.names(DEG),]  
      countscondition1$rowmeans<-rowMeans(countscondition1)                             #create a new column in countscondition with the mean of counts for that genes 
      countscondition2$rowmeans<-rowMeans(countscondition2)
      DEG$mean_counts_condition1 <- countscondition1$rowmeans                           #add the means for each condition to file with all the information about the expressione of DEG
      DEG$mean_counts_condition2 <- countscondition2$rowmeans
write.table(DEG,file="path_to_output_file", sep="\t")                                          #export file with all the DEG 
