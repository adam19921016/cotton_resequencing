#!/bin/bash
gatk=~/biotools/gatk3.8/GenomeAnalysisTK-3.8-1-0-gf15c1c3ef/GenomeAnalysisTK.jar
genome=~/index/Cotton/HAU/bwa/HAU_genome.fa

#filter SNPs within the 5 bp range of Indel
bcftools filter --SnpGap 5 --set-GTs . -s LOWQUAL \
samtools.raw.vcf.gz | bcftools view -f 'PASS' \
--threads 10 -O z -o samtools.filter.vcf.gz 

#selected concordance sites
java -Xmx10g -Djava.io.tmpdir=tmp -jar ${gatk} \
-T SelectVariants -R ${genome} -V gatk.raw.vcf.gz \
--concordance samtools.filter.vcf.gz \
-o union.raw.vcf.gz 2> union.filter.vcf.log

#filter by SNP quality, depth, MAF and missing rate
vcftools --gzvcf --maf 0.05 --max-missing 0.9 \
--max-meanDP 30 --min-meanDP 5 --minQ 30 --recode \
--out union.filter 2>union.filter.vcftools.log