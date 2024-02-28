#!/bin/bash

# PCA
# Usage: run_pca.sh

source activate gd5302
plinkFile="./results/plink/qc/main_hg19_qc_nodups"
outPrefix="./results/P1/plink_pca"
threadnum=12

# pruning
plink2 \
        --bfile ${plinkFile} \
	--maf 0.01 \
	--threads ${threadnum} \
	--indep-pairwise 500 50 0.2 \
        --out ${outPrefix}

# remove related samples using king-cuttoff
# threshold is 0.0884 as https://www.biostars.org/p/434832/
plink2 \
        --bfile ${plinkFile} \
	--extract ${outPrefix}.prune.in \
        --king-cutoff 0.0884 \
	--threads ${threadnum} \
        --out ${outPrefix}

# pca after pruning and removing related samples
# https://www.cog-genomics.org/plink/2.0/basic_stats
plink2 \
        --bfile ${plinkFile} \
        --keep ${outPrefix}.king.cutoff.in.id \
	--extract ${outPrefix}.prune.in \
	--threads ${threadnum} \
        --pca approx allele-wts \
        --out ${outPrefix}

# projection
# https://www.cog-genomics.org/plink/2.0/score#pca_project
plink2 \
        --bfile ${plinkFile} \
	--threads ${threadnum} \
	--score ${outPrefix}.eigenvec.allele 2 6 header-read no-mean-imputation variance-standardize \
        --score-col-nums 7-16 \
        --out ${outPrefix}_projected
