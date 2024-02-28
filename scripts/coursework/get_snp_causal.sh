#!/bin/bash

BaseQC="/home/marco/Documents/uosa/teaching/msc/GD5302/data/base/qc"

# get top 10 SNPs by p-value (lower)
for i in $BaseQC/*.QC.gz; do
  echo "Processing $i"
  zcat "$i" | \
  awk -F'\t' 'NR > 1 {print $1 "\t" $2} NR <= 1' \
  | awk -F'\t' 'NR > 1 {print $1}' | sort -nr | head -n 10 > "${BaseQC}/$(basename ${i} .gz).snp_causal.txt"
done
