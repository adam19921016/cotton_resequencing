#!/bin/bash

#fastqc
fastqc -t 80 *.fq.gz
multiqc *fastqc.zip --pdf

#get the sample name
ls *.fq.gz | awk -F '_' '{print $1"_"$2"_"$3"_"$4}' | uniq > name.txt

#fastq clean
for i in `ls *.fq`; do fastq_clean.sh ; done

#index
gffread HAU.gff3 -T -o HAU.gtf 
hisat2_extract_splice_sites.py ../HAU.gtf > genome.ss 
hisat2_extract_exons.py ../HAU.gtf > genome.exon

#mapping
for i in `cat name.txt`; do hisat2 -p 80 -x HAU_tran -1 $i"_1_clean.fq.gz" -2 $i"_2_clean.fq.gz" -S $i".sam"; done;
for i in `cat name.txt`; do samtools view -bS $i".sam" > $i".bam"; done
#htseq
for i in `cat name.txt`; do htseq-count $i".sam" /HAU.gtf > $i".counts"; done;