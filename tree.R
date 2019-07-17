library(ggtree)
tree<-read.tree('/Users/lilibei/Desktop/snphylo.output.ml.tree')
p<-ggtree(tree,layout = 'circular',branch.length = 'none')
df<-read.table('/Users/lilibei/Desktop/tree/information.txt',header = 1)
p %<+% df + 
    geom_tiplab2(aes(label=name,colour=factor(pop)))+
    theme(legend.position = 'top')
    
p %<+% df + 
    geom_tippoint(aes(colour=factor(pop)))+
    theme(legend.position = 'top')+geom_tiplab2(aes(label=name))