## code to prepare `DATASET` dataset goes here
load("data-raw/nz.rda")

usethis::use_data(nz, overwrite = TRUE)
