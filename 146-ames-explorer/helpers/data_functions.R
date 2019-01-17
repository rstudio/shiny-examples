highlight_prep <- function(data, highlight_rows) {
  # assumes data set has a "selected_" column
  res_filtered <- data %>%
    filter(selected_) %>%
    mutate(label_ind = row_number() %in% highlight_rows)
  
  res_unfiltered <- data %>%
    filter(!selected_) %>%
    mutate(label_ind = FALSE)
  
  res <- bind_rows(res_filtered, res_unfiltered)
  
  return(res)
}
