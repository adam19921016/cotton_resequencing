#!/bin/bash

picard=~/biotools/miniconda3/pkgs/picard-2.18.26-0/share/picard-2.18.26-0/picard.jar

while read sample
    do
    nohup java -Djava.io.tmpdir=tmp -Xmx40g \
    -jar ${picard} MarkDuplicates \
    INPUT=${sample}".sort.bam" \
    OUTPUT=${sample}".sort.mark.bam" \
    METRICS_FILE=${sample}".metric" &
    done < $1