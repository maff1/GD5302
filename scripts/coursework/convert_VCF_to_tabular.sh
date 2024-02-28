#!/bin/bash

BASEDIR="/home/marco/Documents/uosa/teaching/msc/GD5302/data/base"

cd $BASEDIR

source activate gd5302

export XFILES="/home/marco/Documents/uosa/teaching/msc/GD5302/data/base/*.vcf.gz"
export SCRIPTS="/home/marco/Documents/uosa/teaching/msc/GD5302/scripts/coursework"
export OUT="/home/marco/Documents/uosa/teaching/msc/GD5302/data/base/qc"

for i in $XFILES; do
  echo "Processing $i"
  bcftools query \
    -e 'ID == "."' \
    -f '%ID\t%CHROM\t%POS\t%ALT\t%REF\t%AF\t[%ES]\t[%SE]\t[%LP]\n' \
    "$i" | \
    awk 'BEGIN {print "SNP\tCHR\tBP\tA1\tA2\tMAF\tBETA\tSE\tP"}; {OFS="\t"; print}' | \
    # ${SCRIPTS}/qc_gwas_base.R | \
    gzip > "${OUT}/$(basename ${i} .vcf.gz).QC.gz"
done
