compute_bins <- function(x, length=20){
  bins <- seq(min(x), max(x), length.out = length)
  bins
}
