#!/usr/bin/env Rscript

library(data.table)

dat <- data.table::fread( 'cat /dev/stdin', sep="\t", nThread=4 )
  result <- dat[MAF > 0.01, ]
resultNoDups <- result[!duplicated(result$SNP), ]

# remove ambiguous stranded SNPs
ambi <- resultNoDups[A1 == "A" & A2 == "T"
                               | A1 == "T" & A2 == "A"
                               | A1 == "G" & A2 == "C"
                               | A1 == "C" & A2 == "G"]
`%nin%` = Negate( `%in%` )
resultNoAmbi <- resultNoDups[which(resultNoDups$SNP %nin% ambi$SNP),]

# back transform -log10 pvalues
resultNoAmbi$P <- 10^(-resultNoAmbi$P)
print.data.frame( resultNoAmbi, row.names = FALSE )

