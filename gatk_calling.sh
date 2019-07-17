#!/bin/bash

gatk=~/biotools/gatk3.8/GenomeAnalysisTK-3.8-1-0-gf15c1c3ef/GenomeAnalysisTK.jar
refgenome=~/index/Cotton/HAU/bwa/HAU_genome.fa
inputfile=bam.list
path=/home/pele/analysis/reseq/clean_bam/

#RealignerTargetCreator
java -Xmx40g -Djava.io.tmpdir=tmp -jar ${gatk} \
-T RealignerTargetCreator -R ${refgenome} \
--input_file ${inputfile} -o reseq.intervals \
2>reseq_RealignerTC.log

#IndelRealigner
for sample in `cat sample.list`
    do java -Xmx40g -Djava.io.tmpdir=tmp -jar ${gatk} \
    -T IndelRealigner -I ${path}${sample}".filter.bam" \
    -R ${refgenome} -targetIntervals reseq.intervals \
    -o ${sample}".sort.mark.filter.realign.bam" \
    2>${sample}".realign.log" &
    done

#UnifiedGenotyper
java -Xmx40g -Djava.io.tmpdir=tmp -jar ${gatk} \
-T UnifiedGenotyper -R ${refgenome} --input_file ${inputfile} \
--genotyping_mode DISCOVERY -stand_call_conf 30 -glm BOTH -mbq 20 \
-out_mode EMIT_VARIANTS_ONLY -o gatk.raw.vcf.gz 2>gatk.vcf.log
