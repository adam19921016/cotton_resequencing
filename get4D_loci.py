#!/usr/bin/python
import sys
import gzip
import os

codons={'CTT':'L', 'CTC':'L', 'CTA':'L', 'CTG':'L',
                'GTT':'V', 'GTC':'V', 'GTA':'V', 'GTG':'V',
                'TCT':'S', 'TCC':'S', 'TCA':'S', 'TCG':'S',
                'CCT':'P', 'CCC':'P', 'CCA':'P', 'CCG':'P',
                'ACT':'T', 'ACC':'T', 'ACA':'T', 'ACG':'T',
                'GCT':'A', 'GCC':'A', 'GCA':'A', 'GCG':'A',
                'CGT':'R', 'CGC':'R', 'CGA':'R', 'CGG':'R',
                'GGT':'G', 'GGC':'G', 'GGA':'G', 'GGG':'G'}


#get whole genome 4D loci
def get_whole_genome_4Dloci(genome,gff3):
    SNP_4D = []
    ha = {}
    with open(genome,'r') as fd:
        for line in fd:
            line = line.strip()
            if line.startswith('>'):
                key = line[1:]
                seq = ''
            else:
                seq += line
            ha[key] = seq


        with open(gff3,'r') as fd:
            for line in fd:
                if line.split()[2] == 'CDS':
                    line = line.strip()
                    chromosome = line.split()[0]
                    if chromosome.startswith('Scaffold'):
                        continue
                    start_pos = int(line.split()[3])
                    end_pos = int(line.split()[4])
                    seq = ha[chromosome][start_pos-1:end_pos]
                    n = 3
                    for i in range(1,len(seq)+1):
                        aa = seq[n-3:n]
                        if aa in codons.keys():
                            rs = 'rs' + chromosome + "_" + str(start_pos+n-1)
                            chrom = chromosome
                            pos = str(start_pos+n-1)
                            total = rs + '\t' + chrom + '\t' + pos
                            SNP_4D.append(total)
                        n +=3
                    else:
                        continue
                    # print len(SNP_4D)
    result = open('whole_genome_4D_loci','w')

    for line in SNP_4D:
        print >> result,line




if __name__ == "__main__":
    get_whole_genome_4Dloci('HAU.fa','HAU.gene.gff3')
    


