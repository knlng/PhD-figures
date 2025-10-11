---
title: "qc-summary"
author: Linda Nguyen
date: "2025-10-11"
output:
  html_document:
    code_folding: hide
    toc: true
    toc_depth: 5
    number_sections: true
    toc_float:
      collapsed: false
      smooth_scroll: false
    theme: sandstone
  pdf_document:
    toc: true
    toc_depth: 5
    number_sections: true
    df_print: kable
params:
  chapter_name: "chapter4_scRNA-seq" # edit manually
knit: |
  (function(inputFile, encoding) {
    library(rmarkdown)
    # Read the YAML parameters into 'yaml_params' to avoid conflicts
    yaml_params <- rmarkdown::yaml_front_matter(inputFile)$params
    expt_name <- yaml_params$expt_name
    analysis_date <- format(Sys.Date(), "%Y-%m-%d")

    # Output formats to render
    formats <- c("html_document", "pdf_document")
    
    # Corresponding output file extensions
    extensions <- c(".html", ".pdf")
    
    # Render to each format
    for (i in seq_along(formats)) {
      output_file <- paste0(
        "qc-summary", # edit manually
        "_", analysis_date, extensions[i]
      )
      rmarkdown::render(
        input = inputFile, encoding = encoding,
        params = yaml_params,
        output_format = formats[i],
        output_file = output_file)
    }
  })
---

# Introduction

This script creates figures for the PhD chapter ****.

This script:

* creates a grouped bar chart for quality control exclusion criteria


# Setup



Load utilities.


``` r
# load utilities
source("../utils/packages.R")
source("../utils/fonts.R")
source("../utils/setup.R")
source("../utils/theme_thesis.R")
source("../utils/colours.R")

# setup packages and fonts
load_thesis_packages()
setup_latex_fonts()

# setup paths and knitr options
dir.out <- setup_output_dir(params$chapter_name)
setup_knitr_opts(dir.out)
```


# QC retained cells plot

## Preparation

Create the data frame.


``` r
retention_data <- data.frame(
  Sample = c(
    "P13 WT1", "P13 MUT1",
    "P13 WT2", "P13 MUT2",
    "P13 WT3", "P13 MUT3",
    "P18 WT1", "P18 MUT1",
    "P18 WT2", "P18 MUT2",
    "P18 WT3", "P18 MUT3"
  ),
  
  Pre_QC = c(
    3773, 2715,
    16625, 57919,
    3583, 15477,
    2659, 2560,
    4470, 3123,
    3011, 4770
  ),
  
  Final = c(
    1633, 1584,
    8956, 9909,
    1434, 7457,
    1551, 1500,
    2373, 1786,
    176, 72
  )
) %>%
  mutate(
    Retention_Percentage = (Final / Pre_QC) * 100,
    # create factor for proper ordering
    Sample = factor(Sample, levels = c(
      "P13 WT1", "P13 MUT1",
      "P13 WT2", "P13 MUT2",
      "P13 WT3", "P13 MUT3",
      "P18 WT1", "P18 MUT1",
      "P18 WT2", "P18 MUT2",
      "P18 WT3", "P18 MUT3"
    ))
  )

retention_data
```

```
##      Sample Pre_QC Final Retention_Percentage
## 1   P13 WT1   3773  1633            43.281209
## 2  P13 MUT1   2715  1584            58.342541
## 3   P13 WT2  16625  8956            53.870677
## 4  P13 MUT2  57919  9909            17.108375
## 5   P13 WT3   3583  1434            40.022328
## 6  P13 MUT3  15477  7457            48.181172
## 7   P18 WT1   2659  1551            58.330199
## 8  P18 MUT1   2560  1500            58.593750
## 9   P18 WT2   4470  2373            53.087248
## 10 P18 MUT2   3123  1786            57.188601
## 11  P18 WT3   3011   176             5.845234
## 12 P18 MUT3   4770    72             1.509434
```


## Bar chart

Create bar chart showing retention percentages.


``` r
p_retention <-
  ggplot(retention_data, aes(x = Sample, y = Retention_Percentage)) +
  geom_col(
    fill = "black",
    color = "black",
    linewidth = 0.2,
    width = 0.5
  ) +
  
  add_axis_lines(105) +
  scale_y_continuous(breaks = c(0, 20, 40, 60, 80, 100), limits = c(0, 110)) +
  theme_thesis_simple() +
  
  labs(
    x = "Sample",
    y = "Percentage (%)",
    title = "Percentage of cells retained after quality control filtering"
  ) +
  
  # rotate x-axis labels
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

print(p_retention)
```

```
## Warning in geom_segment(aes(x = x_min, xend = x_min, y = 0, yend = y_max), : All aesthetics have length 1, but the data has 12 rows.
## ℹ Please consider using `annotate()` or provide this layer with data containing
##   a single row.
```

<embed src="../../outputs/chapter4_scRNA-seq/bar_qc-retention-percentages-1.pdf" width="576" type="application/pdf" />


``` r
p_retention <-
  ggplot(retention_data, aes(x = Sample, y = Retention_Percentage)) +
  geom_col(
    fill = "black",
    color = "black",
    linewidth = 0.2,
    width = 0.5
  ) +
  
  # Add actual cell count labels above each bar
  geom_text(
    aes(label = Final),  # shows the final cell count
    vjust = -0.5,
    size = 3,
    color = "black"
  ) +
  
  add_axis_lines(105) +
  scale_y_continuous(breaks = c(0, 20, 40, 60, 80, 100), limits = c(0, 110)) +
  theme_thesis_simple() +
  
  labs(
    x = "Sample",
    y = "Percentage (%)",
    title = "Cells retained after quality control"
  ) +
  
  # rotate x-axis labels
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
print(p_retention)
```

```
## Warning in geom_segment(aes(x = x_min, xend = x_min, y = 0, yend = y_max), : All aesthetics have length 1, but the data has 12 rows.
## ℹ Please consider using `annotate()` or provide this layer with data containing
##   a single row.
```

<embed src="../../outputs/chapter4_scRNA-seq/bar_qc-retention-1.pdf" width="576" type="application/pdf" />


# QC exclusion plot

## Preparation

Create the data frame with retention percentages.


``` r
qc_data <- data.frame(
  Sample = c(
    "P13 WT1", "P13 MUT1",
    "P13 WT2", "P13 MUT2",
    "P13 WT3", "P13 MUT3",
    "P18 WT1", "P18 MUT1",
    "P18 WT2", "P18 MUT2",
    "P18 WT3", "P18 MUT3"
  ),
  
  UMI_High = c(
    11.9, 24.8, 14.7, 3.2, 34.7, 11.8,
    6.9, 10.0, 3.6, 12.8, 0.7, 0.1
  ),
  
  UMI_Low = c(
    37.9, 3.1, 30.4, 79.5, 19.7, 38.9,
    31.4, 30.0, 40.7, 26.5, 88.3, 98.4
  ),
  
  Genes_Low = c(
    43.2, 11.9, 28.1, 78.4, 21.5, 36.1,
    30.7, 29.0, 36.8, 26.2, 86.6, 97.5
  ),
  
  Mito_High = c(
    0.3, 0.2, 2.4, 1.7, 3.1, 6.2,
    23.8, 18.4, 14.2, 19.2, 37.4, 41.6
  ),
  
  Haemo_High = c(
    4.1, 7.7, 0.3, 0.5, 5.7, 0.5,
    0.0, 0.2, 0.2, 0.4, 0.1, 31.0
  )
)

qc_data
```

```
##      Sample UMI_High UMI_Low Genes_Low Mito_High Haemo_High
## 1   P13 WT1     11.9    37.9      43.2       0.3        4.1
## 2  P13 MUT1     24.8     3.1      11.9       0.2        7.7
## 3   P13 WT2     14.7    30.4      28.1       2.4        0.3
## 4  P13 MUT2      3.2    79.5      78.4       1.7        0.5
## 5   P13 WT3     34.7    19.7      21.5       3.1        5.7
## 6  P13 MUT3     11.8    38.9      36.1       6.2        0.5
## 7   P18 WT1      6.9    31.4      30.7      23.8        0.0
## 8  P18 MUT1     10.0    30.0      29.0      18.4        0.2
## 9   P18 WT2      3.6    40.7      36.8      14.2        0.2
## 10 P18 MUT2     12.8    26.5      26.2      19.2        0.4
## 11  P18 WT3      0.7    88.3      86.6      37.4        0.1
## 12 P18 MUT3      0.1    98.4      97.5      41.6       31.0
```

Convert to long format for ggplot.


``` r
qc_long <- qc_data %>%
  pivot_longer(
    cols = -Sample,
    names_to = "Exclusion_Type",
    values_to = "Percentage"
  ) %>%
  mutate(
    # create factor for proper ordering
    Sample = factor(Sample, levels = c(
      "P13 WT1", "P13 MUT1",
      "P13 WT2", "P13 MUT2",
      "P13 WT3", "P13 MUT3",
      "P18 WT1", "P18 MUT1",
      "P18 WT2", "P18 MUT2",
      "P18 WT3", "P18 MUT3"
    )),
    
    # clean up exclusion type names
    Exclusion_Type = factor(
      Exclusion_Type,
      levels = c(
        "UMI_High", "UMI_Low", "Genes_Low", "Mito_High", "Haemo_High"
      ),
      labels = c("UMI↑", "UMI↓", "Genes↓", "Mito↑", "Haemo↑")
    )
  )

head(qc_long)
```

```
## # A tibble: 6 × 3
##   Sample   Exclusion_Type Percentage
##   <fct>    <fct>               <dbl>
## 1 P13 WT1  UMI↑                 11.9
## 2 P13 WT1  UMI↓                 37.9
## 3 P13 WT1  Genes↓               43.2
## 4 P13 WT1  Mito↑                 0.3
## 5 P13 WT1  Haemo↑                4.1
## 6 P13 MUT1 UMI↑                 24.8
```


## Bar chart

Create grouped bar chart.


``` r
p <- ggplot(qc_long, aes(x = Sample, y = Percentage, fill = Exclusion_Type)) +
  geom_col(
    position = position_dodge(width = 0.8),
    color = "black",
    linewidth = 0.2
  ) +
  
  scale_fill_manual(
    values = qc_colours,
    labels = c(
      "UMI↑" = TeX("UMI$\\uparrow$"),
      "UMI↓" = TeX("UMI$\\downarrow$"),
      "Genes↓" = TeX("Genes$\\downarrow$"),
      "Mito↑" = TeX("Mito$\\uparrow$"),
      "Haemo↑" = TeX("Haemo$\\uparrow$")
    )
  ) +
  
  add_axis_lines(105) +
  scale_y_continuous(breaks = c(0, 20, 40, 60, 80, 100), limits = c(0, 110)) +
  theme_thesis() +
  
  labs(
    x = "Sample",
    y = TeX("Percentage (%)"),
    title = "Percentage of cells meeting exclusion criteria in each sample"
  )

print(p)
```

<embed src="../../outputs/chapter4_scRNA-seq/bar_qc-exclusion_latex-1.pdf" width="576" type="application/pdf" />


``` r
p_exclusion <- ggplot(qc_long, aes(x = Sample, y = Percentage, fill = Exclusion_Type)) +
  geom_col(
    position = position_dodge(width = 0.8),
    color = "black",
    linewidth = 0.2
  ) +
  
  scale_fill_manual(values = qc_colours) +
  add_axis_lines(105) +
  scale_y_continuous(breaks = c(0, 20, 40, 60, 80, 100), limits = c(0, 110)) +
  theme_thesis_simple() +  # ← Changed here
  
  labs(
    x = "Sample",
    y = "Percentage (%)",
    title = "Percentage of cells meeting exclusion criteria in each sample"
  )

print(p_exclusion)
```

<embed src="../../outputs/chapter4_scRNA-seq/bar_qc-exclusion-1.pdf" width="576" type="application/pdf" />


# Combined figure with labels


``` r
combined_plot <- plot_grid(
  p_retention,
  p_exclusion,
  labels = c("A", "B"),
  label_size = 14,
  label_fontface = "bold",
  ncol = 1,
  align = "v"
)
```

```
## Warning in geom_segment(aes(x = x_min, xend = x_min, y = 0, yend = y_max), : All aesthetics have length 1, but the data has 12 rows.
## ℹ Please consider using `annotate()` or provide this layer with data containing
##   a single row.
```

``` r
print(combined_plot)
```

<embed src="../../outputs/chapter4_scRNA-seq/bar_qc-summary-1.pdf" width="576" type="application/pdf" />


# Session info


``` r
sessionInfo()
```

```
## R version 4.4.3 (2025-02-28)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 22.04.5 LTS
## 
## Matrix products: default
## BLAS:   /usr/lib/x86_64-linux-gnu/blas/libblas.so.3.10.0 
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.10.0
## 
## locale:
##  [1] LC_CTYPE=C.UTF-8       LC_NUMERIC=C           LC_TIME=C.UTF-8       
##  [4] LC_COLLATE=C.UTF-8     LC_MONETARY=C.UTF-8    LC_MESSAGES=C.UTF-8   
##  [7] LC_PAPER=C.UTF-8       LC_NAME=C              LC_ADDRESS=C          
## [10] LC_TELEPHONE=C         LC_MEASUREMENT=C.UTF-8 LC_IDENTIFICATION=C   
## 
## time zone: Europe/London
## tzcode source: system (glibc)
## 
## attached base packages:
## [1] grid      stats     graphics  grDevices utils     datasets  methods  
## [8] base     
## 
## other attached packages:
##  [1] latex2exp_0.9.6       showtext_0.9-7        showtextdb_3.0       
##  [4] sysfonts_0.8.9        kableExtra_1.4.0      png_0.1-8            
##  [7] ggrepel_0.9.6         RColorBrewer_1.1-3    circlize_0.4.16      
## [10] ComplexHeatmap_2.22.0 ggpointdensity_0.2.0  colorspace_2.1-1     
## [13] viridis_0.6.5         viridisLite_0.4.2     patchwork_1.3.1      
## [16] cowplot_1.2.0         lubridate_1.9.4       forcats_1.0.0        
## [19] stringr_1.5.1         dplyr_1.1.4           purrr_1.1.0          
## [22] readr_2.1.5           tidyr_1.3.1           tibble_3.3.0         
## [25] ggplot2_3.5.2         tidyverse_2.0.0       formatR_1.14         
## [28] knitr_1.50            rmarkdown_2.29       
## 
## loaded via a namespace (and not attached):
##  [1] gtable_0.3.6        shape_1.4.6.1       rjson_0.2.23       
##  [4] xfun_0.53           bslib_0.9.0         GlobalOptions_0.1.2
##  [7] tzdb_0.5.0          vctrs_0.6.5         tools_4.4.3        
## [10] generics_0.1.4      stats4_4.4.3        parallel_4.4.3     
## [13] cluster_2.1.8.1     pkgconfig_2.0.3     S4Vectors_0.44.0   
## [16] lifecycle_1.0.4     compiler_4.4.3      farver_2.1.2       
## [19] textshaping_1.0.1   codetools_0.2-20    clue_0.3-66        
## [22] htmltools_0.5.8.1   sass_0.4.10         yaml_2.3.10        
## [25] pillar_1.11.0       crayon_1.5.3        jquerylib_0.1.4    
## [28] cachem_1.1.0        iterators_1.0.14    foreach_1.5.2      
## [31] tidyselect_1.2.1    digest_0.6.37       stringi_1.8.7      
## [34] labeling_0.4.3      fastmap_1.2.0       cli_3.6.5          
## [37] magrittr_2.0.3      utf8_1.2.6          withr_3.0.2        
## [40] scales_1.4.0        timechange_0.3.0    matrixStats_1.5.0  
## [43] gridExtra_2.3       GetoptLong_1.0.5    hms_1.1.3          
## [46] evaluate_1.0.4      IRanges_2.40.1      doParallel_1.0.17  
## [49] rlang_1.1.6         Rcpp_1.1.0          glue_1.8.0         
## [52] xml2_1.4.0          BiocGenerics_0.52.0 svglite_2.2.1      
## [55] rstudioapi_0.17.1   jsonlite_2.0.0      R6_2.6.1           
## [58] systemfonts_1.2.3
```
