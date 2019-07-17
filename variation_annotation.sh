#!/bin/bash


#convert vcf format for snps
﻿perl ~/biotools/annovar/annovar/convert2annovar.pl \
-format vcf4old 436.snp.filter.vcf.gz > 436.snp.avinput \
2>436.snp.avinput.log

#convert vcf format for indels
perl ~/biotools/annovar/annovar/convert2annovar.pl \
-format vcf4old 436.indel.filter.vcf.gz > 436_indel.avinput \
2>436_indel.avinput.log

#snp annotation
perl ~/biotools/annovar/annovar/annotate_variation.pl \
-out 436.snp -build Gh 436.snp.avinput Gh

#indel annotation
perl ~/biotools/annovar/annovar/annotate_variation.pl \
-out 436.indel -build Gh 436.indel.avinput Gh