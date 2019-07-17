#!/bin/bash

picard=~/biotools/miniconda3/pkgs/picard-2.18.26-0/share/picard-2.18.26-0/picard.jar

while read sample
    do
    nohup java -Djava.io.tmpdir=tmp -Xmx40g \
    -jar ${picard} SortSam I=${sample}".bam" \
    O=${sample}".sort.bam" SORT_ORDER="coordinate" &
    done < $1