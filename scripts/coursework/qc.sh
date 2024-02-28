#!/bin/bash

# QC 1K genomes data (phase 3)
# Usage: qc.sh

# QC out: main_hg19

source activate gd5302

mainDir="/home/marco/Documents/uosa/teaching/msc/GD5302"
cd "$mainDir"
genoFile="./data/target/1k.phase3.hg19"
resDir="./results/plink/qc"

plink \
    --bfile "$genoFile" \
    --maf 0.01 \
    --hwe 1e-6 \
    --geno 0.01 \
    --mind 0.01 \
    --make-just-fam \
    --write-snplist \
    --out ${resDir}/main_hg19_qc

plink \
    --bfile "$genoFile" \
    --keep ${resDir}/main_hg19_qc.fam \
    --extract ${resDir}/main_hg19_qc.snplist \
    --indep-pairwise 200 50 0.25 \
    --out ${resDir}/main_hg19_qc

plink \
    --bfile "$genoFile" \
    --extract ${resDir}/main_hg19_qc.prune.in \
    --keep ${resDir}/main_hg19_qc.fam \
    --het \
    --out ${resDir}/main_hg19_qc

Rscript ./scripts/coursework/qc_f_coef_het.R

plink \
    --bfile "$genoFile" \
    --extract ${resDir}/main_hg19_qc.prune.in \
    --keep ${resDir}/main_hg19_qc.valid.sample \
    --check-sex \
    --out ${resDir}/main_hg19_qc

plink \
    --bfile "$genoFile" \
    --extract ${resDir}/main_hg19_qc.prune.in \
    --keep ${resDir}/main_hg19_qc.valid.sample \
    --rel-cutoff 0.125 \
    --out ${resDir}/main_hg19_qc

plink \
    --bfile "$genoFile" \
    --make-bed \
    --keep ${resDir}/main_hg19_qc.rel.id  \
    --out ${resDir}/main_hg19_qc \
    --extract ${resDir}/main_hg19_qc.snplist
