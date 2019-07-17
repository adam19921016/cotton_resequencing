#!/bin/bash

#the path of the clean data
path=/database/public/reseq/cleandata/

threads=30
index=/home/pele/index/Cotton/HAU/bwa/HAU_genome

while read sample
    do
    nohup bwa mem -t ${threads} \
    -R "@RG\tID:${sample}\tSM:${sample}\tLB:reseq\tPL:Illumina" \
    ${index} \
    ${path}${sample}"_1_clean.fq.gz" \
    ${path}${sample}"_2_clean.fq.gz" \
    -o ${sample}".sam" 2>${sample}".bwa.align.log" &
    done < $1