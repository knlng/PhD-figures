# thesis theme with LaTeX font
theme_thesis <- function() {
  theme_minimal() +
    theme(
      text = element_text(family = "cmu_serif"),
      axis.text.x = element_text(angle = 45, hjust = 1, size = 10),
      axis.text.y = element_text(size = 10),
      legend.position = "top",
      legend.title = element_blank(),
      panel.grid.minor = element_blank(),
      panel.grid.major.x = element_blank(),
      plot.title = element_text(hjust = 0.5)
    )
}

# thesis theme without LaTeX font
theme_thesis_simple <- function() {
  theme_minimal() +
    theme(
      axis.text.x = element_text(angle = 45, hjust = 1, size = 10),
      axis.text.y = element_text(size = 10),
      legend.position = "top",
      legend.title = element_blank(),
      panel.grid.minor = element_blank(),
      panel.grid.major.x = element_blank(),
      plot.title = element_text(hjust = 0.5)
    )
}

# add consistent axis lines to plots
add_axis_lines <- function(y_max = 105, x_min = 0.5) {
  list(
    geom_hline(yintercept = 0, color = "black", linewidth = 0.5),
    geom_segment(
      aes(x = x_min, xend = x_min, y = 0, yend = y_max), 
      color = "black", linewidth = 0.3
    )
  )
}

# alternative theme without LaTeX font (fallback)
theme_thesis_fallback <- function() {
  theme_minimal() +
    theme(
      axis.text.x = element_text(angle = 45, hjust = 1, size = 10),
      axis.text.y = element_text(size = 10),
      legend.position = "top",
      legend.title = element_blank(),
      panel.grid.minor = element_blank(),
      panel.grid.major.x = element_blank(),
      plot.title = element_text(hjust = 0.5)
    )
}