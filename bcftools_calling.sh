#!/bin/bash

refgenome=~/index/Cotton/HAU/bwa/HAU_genome.fa
bamlist=bam.list

bcftools mpileup -f ${refgenome} -b ${bamlist} \
-O b --threads 10 | bcftools call --threads 10 \
-vmO z -o samtools.raw.vcf.gz 2> bcftools_calling.log 
    
   
    
 
