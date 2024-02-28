#!/bin/bash

# Simulate QC'ed data
# Usage: simulate.sh

source activate gd5302

mainDir="/home/marco/Documents/uosa/teaching/msc/GD5302"
cd "$mainDir"
genoFile="./results/plink/qc/main_hg19_qc_nodups"
resDir="./results/gcta"
causalDir="./data/base/qc/ieu-a-298.QC.snp_causal.txt"

gcta  \
	--bfile "$genoFile" \
	--simu-cc 917 918  \
	--simu-causal-loci "$causalDir"  \
	--simu-hsq 0.6  \
	--simu-k 0.5  \
	--simu-rep 3  \
	--out ${resDir}/main_hg19_qc_nodups_ad