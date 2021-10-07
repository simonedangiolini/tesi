path_to_all_protein_connection<-$1
path_to_convertion_name_gene_to_protein<-$2
path_to_DEG_comparison2<-$3
path_to_DEG_comparison2<-$4
output_file1_path<-$5
output_file2_path<-$6


connessioni<-read.table(file="path_to_all_protein_connection", header=TRUE)
traduzione<-read.table(file="path_to_convertion_name_gene_to_protein", header=TRUE) 
colnames (traduzione)[1]<-"protein1"
colnames (traduzione)[2]<-"gene_1"
definitive<- join(connessioni, traduzione, by="protein1", type="left")
colnames (traduzione)[1]<-"protein2"
colnames (traduzione)[2]<-"gene_2"
definitive<- join(definitive, traduzione, by="protein2", type="left")
definitive<-definitive[c("protein1","gene_1","protein2","gene_2","homology","experiments","experiments_transferred","database","database_transferred","textmining","textmining_transferred","combined_score")]
ALLoVd=read.table(file="path_to_DEG_comparison1", header=TRUE)
ALLyVd=read.table(file="path_to_DEG_comparison2", header=TRUE)


connessioni_yVd<-data.frame(matrix(ncol=12,nrow = 0))
for (row in 1:nrow(definitive)){
  if (definitive[row,2] %in% row.names(ALLyVd)) {   
    connessioni_yVd<-rbind(connessioni_yVd, definitive[row,]) 
  }
}

connessioni2_yVd<-data.frame(matrix(ncol=12,nrow = 0))
for (row in 1:(connessioni_yVd)){
  if (connessioni_yVd[row,4] %in% row.names(ALLyVd)) {   
    connessioniy_yVd<-rbind(connessioni2_yVd, connessioni_yVd[row,])
  }
}

###############################


connessioni_oVd<-data.frame(matrix(ncol=12,nrow = 0))
for (row in 1:nrow(definitive)){
  if (definitive[row,2] %in% row.names(ALLoVd)) {   
    connessioni_oVd<-rbind(connessioni_oVd, definitive[row,]) 
  }
}

connessioni2_oVd<-data.frame(matrix(ncol=12,nrow = 0))
for (row in 1:(connessioni_oVd)){
  if (connessioni_oVd[row,4] %in% row.names(ALLoVd)) {   
    connessioni2_oVd<-rbind(connessioni2_oVd, connessioni_oVd[row,]) 
  }
}

#we delete all the lines of the connections where only texmining and texmining transferred are different from 0
connessioni_oVd<-connessioni_oVd[connessioni_oVd$homology!=0 | connessioni_oVd$experiments!=0 | connessioni_oVd$experiments_transferred!=0 | connessioni_oVd$database!=0 | connessioni_oVd$database_transferred!=0,]
connessioni_yVd<-connessioni_yVd[connessioni_yVd$homology!=0 | connessioni_yVd$experiments!=0 | connessioni_yVd$experiments_transferred!=0 | connessioni_yVd$database!=0 | connessioni_yVd$database_transferred!=0,]

#we delete all the connections present in double copies
for (row in 1:nrow(connessioni_oVd)){
  if (connessioni_oVd[row,2]>connessioni_oVd[row,4]){
    x=connessioni_oVd[row,2]
    y=connessioni_oVd[row,4]
    connessioni_oVd[row,2]=y
    connessioni_oVd[row,4]=x
  }
}

connessioni_oVd_sorted_ alphabetically<-connessioni_oVd
connessioni_oVd_sorted_ alphabetically<-connessioni_oVd[order(connessioni_oVd[,2],connessioni_oVd[,4]),]
row.names(connessioni_oVd_sorted_ alphabetically)<-rep(1:nrow(connessioni_oVd_sorted_ alphabetically)
righe_da_eliminare=c()
for (row in 1:nrow(connessioni_oVd_sorted_ alphabetically)){
  if (connessioni_oVd_sorted_ alphabetically[row,2]==connessioni_oVd_sorted_ alphabetically[row+1,2] & connessioni_oVd_sorted_ alphabetically[row,4]==connessioni_oVd_sorted_ alphabetically[row+1,4] ){
    righe_da_eliminare<-append(righe_da_eliminare,row+1)
  }
}
connessioni_oVd_finali<-connessioni_oVd_sorted_ alphabetically[!row.names(connessioni_oVd_sorted_ alphabetically)%in%righe_da_eliminare,]


#do the same for the other comparison

for (row in 1:nrow(connessioni_yVd)){
  if (connessioni_yVd[row,2]>connessioni_yVd[row,4]){
    x=connessioni_yVd[row,2]
    y=connessioni_yVd[row,4]
    connessioni_yVd[row,2]=y
    connessioni_yVd[row,4]=x
  }
}

connessioni_yVd_sorted_ alphabetically<-connessioni_yVd
connessioni_yVd_sorted_ alphabetically<-connessioni_yVd[order(connessioni_yVd[,2],connessioni_yVd[,4]),]
row.names(connessioni_yVd_sorted_ alphabetically)<-rep(1:nrow(connessioni_yVd_sorted_ alphabetically)
righe_da_eliminare=c()
for (row in 1:nrow(connessioni_yVd_sorted_ alphabetically)){
  if (connessioni_yVd_sorted_ alphabetically[row,2]==connessioni_yVd_sorted_ alphabetically[row+1,2] & connessioni_yVd_sorted_ alphabetically[row,4]==connessioni_yVd_sorted_ alphabetically[row+1,4] ){
    righe_da_eliminare<-append(righe_da_eliminare,row+1)
  }
}
connessioni_yVd_finali<-connessioni_yVd_sorted_ alphabetically[!row.names(connessioni_yVd_sorted_ alphabetically)%in%righe_da_eliminare,]




write.table(connessioni_yVd_expdb, paste(path, "output_file1_path", sep="/"), row.names = FALSE, quote = FALSE)
write.table(connessioni_oVd_expdb, paste(path, "output_file2_path", sep="/"), row.names = FALSE, quote = FALSE)



