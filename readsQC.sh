#!/bin/bash

#the path of the raw data 
path=/database/public/reseq/rawdata/

#parameters of trimmomatic
HEADCROP=5
CROP=140
MINLEN=100

while read smaple
    do
    nohup trimmomatic PE -threads 70 \
    ${paath}${smaple}"_1.fq.gz" \
    ${path}${smaple}"_2.fq.gz" \
    ${smaple}"_1.fq.gz" ${smaple}_1_unpair.fq.gz \
    ${smaple}"_2.fq.gz" ${smaple}_2_unpair.fq.gz \
    HEADCROP:${HEADCROP} CROP:${CROP} \
    SLIDINGWINDOW:4:15 MINLEN:${MINLEN} &
    done < $1