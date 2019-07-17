#!/bin/bash

threads=30

while read sample
    do
    nohup samtools view \
    -@ ${threads} \
    -bS ${sample}".sam" \
    -o ${sample}".bam" &
    done < $1