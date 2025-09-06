# setup LaTeX fonts for figures
setup_latex_fonts <- function() {
  library(showtext)
  library(latex2exp)
  
  # add LaTeX font (check if font exists first)
  font_path <- "/usr/share/fonts/truetype/cmu/cmunrb.ttf"
  if (file.exists(font_path)) {
    font_add("cmu_serif", font_path)
    showtext_auto()
    message("CMU Serif font loaded successfully.")
  } else {
    warning("CMU Serif font not found at ", font_path, ". Using default font.")
  }
}

# helper function to check if LaTeX font is available
is_latex_font_available <- function() {
  font_path <- "/usr/share/fonts/truetype/cmu/cmunrb.ttf"
  return(file.exists(font_path))
}