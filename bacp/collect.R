lsDirs <- list.dirs('.',recursive=FALSE)
library(data.table)
t <- data.table()
for (d in lsDirs){
    d <- basename(d)
    t1 <- fread(paste(d,'/info.csv',sep=''))
    t1$set <- d
    if (nrow(t)==0)
        t <- t1
    else
        t <- rbind(t,t1)
}
minSolverTime <- 10
t1 <- t[solverTime>=minSolverTime]
print(t1)

lsInsts <- sapply(c(1:nrow(t1)), function(i) paste(t1$set[i],'/params/',t1$instance[i],'.param',sep=''))
t1$instance <- lsInsts
writeLines(lsInsts, con<-file('./list-10s-600s.txt')); close(con)
write.table(t1[,-c('set','model','solverNodeOut','nNodes','cmd','bound','snsTimeLimit'),with=FALSE],file='./info-10s-600s.csv',sep=',',quote=FALSE,row.names=FALSE,col.names=TRUE)
