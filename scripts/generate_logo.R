#!/usr/bin/env Rscript

# generate sticker for module teaching using a manhattan plot
generate_hex_sticker <- function(seed = 1000, nsim = 50000, filename = "~/Downloads/logo.png") {

  library(hexSticker)
  library(ggmanh)
  library(SeqArray)
  library(ggplot2)
  
  set.seed(seed)
  simdata <- data.frame(
    "chromosome" = sample(c(1:22,"X"), size = nsim, replace = TRUE),
    "position" = sample(1:100000000, size = nsim),
    "P.value" = rbeta(nsim, shape1 = 5, shape2 = 1)^7
  )
  g <- manhattan_plot(x = simdata, pval.colname = "P.value", 
                      chr.colname = "chromosome", pos.colname = "position", 
                      plot.title = "", y.label = "P")
  p <- g + theme_void() + theme_transparent() + guides(color = FALSE) + geom_point(size = 0.3)
  p$layers[[2]] <- NULL
  s <- sticker(p, package="GD5302", p_size=20, 
               s_x=1, s_y=1, 
               s_width=1.2, 
               s_height=1, 
               h_fill = "#FFFFFF", 
               p_color = "#1881C2",
               h_color = "#1881C2",
               filename = filename)
save_sticker(filename, s)
}

generate_hex_sticker()