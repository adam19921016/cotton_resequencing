library(ggplot2)
df<-read.table('/Users/lilibei/Desktop/analysis/pca/pca.eigenvec')
ggplot(df,aes(V1,V2,colour=V4))+
    geom_point(alpha=0.9)+scale_colour_manual(values = c('red2','green2','blue2'))+
    theme_classic()+
    theme(legend.position='top',legend.title=element_blank(),legend.key=element_blank())+
    xlab('PCA1')+ylab('PCA2')