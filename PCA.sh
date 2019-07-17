#convert vcf to plink
vcftools --vcf cotton.vcf --maf 0.05 --max-missing 0.9 --recode  --plink --out cotton 

#gcta -> PCA
plink --noweb --file cotton --make-bed --out cotton
gcta64 --bfile cotton --make-grm --out cotton --thread-num 10 --autosome-num  26
gcta64 --grm cotton --pca 5 --out cotton --thread-num 10 




