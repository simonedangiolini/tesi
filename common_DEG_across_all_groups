path_to_DEG1<-$1
path_to_DEG2<-$2
path_to_DEG3<-$3


ALLyVd<-read.table("path_to_DEG1")
ALLoVd<-read.table("path_to_DEG2")
ALLyVo<-read.table("path_to_DEG3")


library(eulerr)
yVd_oVd<-length(intersect(row.names(ALLoVd),row.names(ALLyVd)))
yVd_yVo<-length(intersect(row.names(ALLyVo),row.names(ALLyVd)))
oVd_yVo<-length(intersect(row.names(ALLoVd),row.names(ALLyVo)))
fit <- euler(c("youngVdis" = length(row.names(ALLyVd))-length(intersect(row.names(ALLoVd),row.names(ALLyVd)))-length(intersect(row.names(ALLyVo),row.names(ALLyVd))) ,
                "oldVdis" = length(row.names(ALLoVd))-length(intersect(row.names(ALLoVd),row.names(ALLyVd)))-length(intersect(row.names(ALLoVd),row.names(ALLyVo))), 
               "youngVold" = length(row.names(ALLyVo))-length(intersect(row.names(ALLyVo),row.names(ALLyVd)))-length(intersect(row.names(ALLoVd),row.names(ALLyVo))), 
               "youngVdis&oldVdis"= yVd_oVd, 
               "youngVdis&youngVold"= yVd_yVo,
               "oldVdis&youngVold"= oVd_yVo))
plot(fit, quantities= TRUE)    #now we have the Eulero Venn graph about the DEG common to all the comparisons


ALLyVd<-subset(ALLyVd, select=c("log2FoldChange", "padj"))
ALLoVd<-subset(ALLoVd, select=c("log2FoldChange", "padj"))
ALLyVo<-subset(ALLyVo, select=c("log2FoldChange", "padj"))

colnames(ALLyVd) <- c("log2FC_yVd", "padj_yVd")
colnames(ALLoVd) <- c("log2FC_oVd", "padj_oVd")
colnames(ALLyVo) <- c("log2FC_yVo", "padj_yVo")

ALLyVd$name<-row.names(ALLyVd)
ALLoVd$name<-row.names(ALLoVd)
ALLyVo$name<-row.names(ALLyVo)

library(plyr)
ALL<-join (ALLyVd, ALLoVd, by="name" , type= "full" )
ALL<-join(ALL, ALLyVo, by="name", type="full")
row.names(ALL)<-ALL$name
ALL<-ALL[order(row.names(ALL)),]  #here we a have the ALL the DEG and the information about what was the comparison or comparisons of provenance
