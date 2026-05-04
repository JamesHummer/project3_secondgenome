center_log_ratio <- function(x) {
  exp(log(x) - mean(log(x)))
}

