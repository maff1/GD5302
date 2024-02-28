#!/bin/sh

# DOWNLOAD GWAS summary stats from https://gwas.mrcieu.ac.uk (VCF format, two files including the VCF index)
BASE="/home/marco/Documents/uosa/teaching/msc/GD5302/data/base"
cd $BASE

for gwas in `cat gwas.list`
  do
    wget ${gwas}.vcf.gz -O ${BASE}/${gwas##*/}.vcf.gz;
	  wget ${gwas}.vcf.gz.tbi -O ${BASE}/${gwas##*/}.vcf.gz.tbi;
done;
