library(grid)
library(ggplot2)
library(maps)
world <- map_data("world")
world <- world[world$region != "Antarctica",] 
gg <- ggplot()
gg <- gg + geom_map(data=world, map=world,
                    aes(x=long, y=lat, map_id=region),
                    color="white", fill="#7f7f7f", size=0.05, alpha=1/4)
#gg + geom_point(data=f, aes(x=JD, y=WD, color=Ecological_region),size=1.5)
gg + geom_point(data=f, aes(x=JD, y=WD, color=Ecological_region),size=1.8)+theme(legend.position=c(0.08,.78))+scale_color_manual(values = c('orange','blue','purple','red','yellow2','green'),limits=c('Wild','MFP','NSER','NIR','YRR','YZRR'))+labs(color='Ecological region')
#pie plot
pie_map<-read.table('/Users/lilibei/Desktop/pie_map.txt',header = 1,check.names = 0)
pp<-ggplot(data=pie_map,aes(x='',y=number,fill=region))+geom_bar(stat='identity',width=1)+theme_minimal()+xlab('')+ylab('')+theme(axis.text.y=element_blank())+scale_y_continuous(breaks=NULL)+geom_text(aes(label=number,y=number/3+c(0,cumsum(number)[-length(number)])))+coord_polar("y",start=0)+guides(fill=FALSE)+scale_fill_manual(values = c('blue','red','purple','orange','yellow2','green'))
#merge
subvp<-viewport(width = .35,height = .35,x=.12,y=.18)
print(pp,vp=subvp)