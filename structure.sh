#!/bin/bash

#vcf2plink
vcftools --gzvcf 436.reseq.filter.vcf.gz --maf 0.05 --plink --out 436_ms0.1_maf0.05

#plink2bed
plink --noweb --file 436_ms0.1_maf0.05 --make-bed --out 436_ms0.1_maf0.05

#Calculation K from 2 to 10

for i in {2..10}
    do 
    structure.py -K $i --input=436_ms0.1_maf0.05 \
    --output ms0.1_maf0.05 
    done
    
#choose the best K value
chooseK.py --input=ms0.1_maf0.05

#plot
#step1
python ../structure.py -K 3 --input=cotton --output=cotton
#step2
python ../distruct.py -K 3 --input=3cotton --output=./result.png#step2 input using the step1 output