#!/usr/bash

#output format to plink
vcftools --gzvcf cotton.vcf.gz --plink --out cotton

#output format to bed
plink --noweb --file cotton --make-bed --out cotton

#Estimate Relatedness Matrix 
gemma -bfile cotton -gk -o cotton -maf 0.05 -miss 0.1 &

#association analysis
gemma -bfile sww -k output/cotton.cXX.txt -lmm  -o result -maf 0.05 -miss 0.1 -n 1