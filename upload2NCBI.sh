#!/bin/bash

#upload RNA-seq data
~/.aspera/connect/bin/ascp -i ~/aspera.openssh \
-k1 -QT -l200m  -d data/submission/RNAseq_rawdata/ \
subasp@upload.ncbi.nlm.nih.gov:uploads/LILIBEI1989@sina.com_GW3RPeie

#upload resequencing data
for i in `cat SRA.list`
    do
    ~/.aspera/connect/bin/ascp -i ~/sra-4.ssh.priv \
    -k 1 -T -l200m data/submission/$i asp-sra@upload.ncbi.nlm.nih.gov:incoming
    done