#!/usr/bin/env Rscript

library(data.table)

mainDir <- "/home/marco/Documents/uosa/teaching/msc/GD5302"
resDir <- file.path( mainDir, "results/plink/qc" )
setwd( mainDir )
dat <- fread( "results/plink/qc/main_hg19_qc.het" )
# Get samples with F coefficient within 3 SD of the population mean
valid <- dat[F<=mean(F)+3*sd(F) & F>=mean(F)-3*sd(F)] 
# print FID and IID for valid samples
fwrite( valid[,c("FID","IID")], file.path( resDir, "main_hg19_qc.valid.sample"), sep="\t" ) 