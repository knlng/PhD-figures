# setup knitr options for thesis figures
setup_knitr_opts <- function(output_dir) {
  knitr::opts_chunk$set(
    echo = TRUE,
    dev = c("pdf", "png"),
    fig.path = paste0(output_dir, "/"),
    tidy.opts = list(width.cutoff = 80)
  )
}

# create output directory if it doesn't exist
setup_output_dir <- function(chapter_name) {
  dir.out <- paste0("../../outputs/", chapter_name)
  if (!dir.exists(dir.out)) {
    dir.create(dir.out, recursive = TRUE)
  }
  return(dir.out)
}