# load all packages commonly used for figures
load_thesis_packages <- function() {
  # formatting
  library(knitr)
  library(formatR)
  
  # data structure and visualisation
  library(tidyverse)
  library(cowplot)
  library(patchwork)
  library(viridis)
  library(colorspace)
  library(ggpointdensity)
  library(ComplexHeatmap)
  library(circlize)
  library(RColorBrewer)
  library(ggrepel)
  library(png)
  library(kableExtra)
  
  # LaTeX support (loaded by setup_latex_fonts)
  # library(showtext)
  # library(latex2exp)
  
  # sc related packages
  library(SingleCellExperiment)
  library(scater)
  
  
  message("Packages loaded successfully.")
}