#!/usr/bin/env python
#coding=utf-8

def LDheatmap_plot(self,start_pos,end_pos):
        LD_file_name = start_pos + '_' + end_pos
        with open(self.haplotype,'r') as fd:
            n = 0
            for line in fd:
                line_list = line.split()
                n +=1
                if re.search(start_pos,line): 
                    start_number = n
                    chrom_start = line_list[2]
                elif re.search(end_pos,line):
                    end_number = n
                    chrom_end = line_list[2] 
            if not  chrom_start == chrom_end:
                print 'The chromosome is different!' 
                sys.exit()
        result = open(LD_file_name,'w')
        with open(self.haplotype,'r') as fd:
            n = 0
            for line in fd:
                n += 1
                if int(n) in  range(int(start_number),int(end_number)+1):
                    print >> result,line,
        result.close()
        LD_file_name_sub = LD_file_name + '_sub'
        #make the haplotype as the A/G
        result = open(LD_file_name_sub,'w')
        with open(LD_file_name,'r') as fd:
            for line in fd:
                line_list = line.split()
                #get the ATCG
                SNP1 = line_list[1][0]
                SNP2 = line_list[1][2]
                line = re.sub(SNP1+SNP1,SNP1+'/'+SNP1,line)
                line = re.sub(SNP2+SNP2,SNP2+'/'+SNP2,line)
                line = re.sub(SNP1+SNP2,SNP1+'/'+SNP2,line)
                line = re.sub('NN','NA',line)
                print >> result,line,
        result.close()
        cmd = '''
        df<-read.table('%s')
        data<-df[,-c(2:11)]
        #Calculate the length
        distance_bp<-df[,4]
        a<-t(data)
        colnames(a)<-a[1,]
        a<-a[-1,]
        library(LDheatmap)
        library(grid)
        library(genetics)
        data1 <- makeGenotypes(a)
        pdf('%s.pdf',width=20,height=15)
        my_palette <- colorRampPalette(c("red","white", "gray60"))(n = 299)
        LDheatmap(data1,genetic.distances=distance_bp,col=my_palette)
        dev.off()
        ''' % (LD_file_name_sub,LD_file_name)
        R_script = open('LDheatmapplot.R','w')
        R_script.write(cmd)
        R_script.close()
        os.system('Rscript LDheatmapplot.R')
        os.remove('LDheatmapplot.R')