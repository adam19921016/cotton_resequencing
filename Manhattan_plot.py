args<-commandArgs(T)
library(CMplot)
df<-read.table(args[1],header=1)
CMplot(df,amplify = 0,plot.type = c('m','q'),multracks=1)