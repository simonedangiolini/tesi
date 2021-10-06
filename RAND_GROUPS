
path_to_gene_couts<-$1
condition1<-$2
condition2<-$3
path_to_file_with_protein_coding_gene_name_in_references_genome<-$4

DEG<-c()   #Create the empty that will contain the result of each cycle
library("BiocParallel")
directory <- "path_to_gene_couts"
sampleFiles<-grep(condition1|condition2,list.files(directory),value=TRUE)
vector<- c(condition1,condition1,condition2,condition2) #assign to every sample the right condition
for (i in 1:1000){
  condition<-vector
  position1<-sample(x:y, z, replace=F)           #select z casual number from the interval x:y (x and y are the position in "vector" of our samples with the condition 1)
  for (x in 1:4){                                 
    condition[position1[x]]<-condition2   #changhe some samples of the condition1 with condition2          
  }
  position2<-sample(x2:y2, z2, replace=F)       #elect z2 casual number from the interval x2:y2 (x2 and y2 are the position in "vector" of our samples with the condition 2)
  for (y in 1:4){
    condition[position2[y]]<-condition1               #changhe some samples of the condition2 with condition1
  }
  #we now have a vector of conditions where randomly a number z and z2 of samples have been changed of condition, on this vector we'll do the same analyses used to obtain the DEG with che 2 assigned correctly
  sampleTable<- data.frame(sampleName=sampleFiles, #this is the same analys did with the samples with them right condition
                           fileName=sampleFiles,
                           condition= condition)
  sampleTable$condition <- factor(sampleTable$condition)
  library("DESeq2", warn.conflicts = FALSE)
  ddsHTSeq <- DESeqDataSetFromHTSeqCount(sampleTable = sampleTable,
                                         directory = directory,
                                         design = ~condition)
  keep <- rowSums(counts(ddsHTSeq)) >= 10
  ddsHTSeq <- ddsHTSeq[keep,]
  ddsHTSeq<-DESeq(ddsHTSeq)
  results(ddsHTSeq)
  res <- results(ddsHTSeq, contrast=c("condition",condition1,condition2))
  deseq2ResA <- as.data.frame(res)
  protein_cod<-read.table("path_to_file_with_protein_coding_gene_name_in_references_genome", fill = TRUE)
  deseq2ResAFinal<-deseq2ResA
  deseq2ResAFinal<-deseq2ResAFinal[intersect(rownames(deseq2ResAFinal),protein_cod$V2),]
  deseq2ResAFinal$diffexpressed <- "NO"
  deseq2ResAFinal$diffexpressed[deseq2ResAFinal$log2FoldChange > 0 & deseq2ResAFinal$padj < 0.05] <- "UP"
  deseq2ResAFinal$diffexpressed[deseq2ResAFinal$log2FoldChange < 0 & deseq2ResAFinal$padj < 0.05] <- "DOWN"
  ALLR<-subset(deseq2ResAFinal, diffexpressed=="DOWN" | diffexpressed=="UP")                                  
  DEG[i]<-nrow(ALLR)                                                  #in DEG we put everytime the number of the DEG obtained in that randomization cycle
}  
hist(vector, breaks = 100, main="Condition1VCondition2", ylab = "Frequence", xlab="Number of DEG") #so we can see the distribution of the number of DEG for all the 1000 cycles

