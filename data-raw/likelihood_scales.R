## code to prepare `ipcc_likelihood_scale` dataset goes here

library(magrittr)

ipcc_likelihood_scale <- tibble::tribble(
  ~ term, ~ left_break, ~ right_break, ~ left_open, ~ right_open,
  "Virtually certain", 0.99, 1.00, TRUE, FALSE,
  "Extremely likely", 0.95, 0.99, TRUE, FALSE,
  "Very likely", 0.90, 0.95, TRUE, FALSE,
  "Likely", 0.66, 0.90, TRUE, FALSE,
  "About as likely as not", 0.33, 0.66, FALSE, FALSE,
  "Unlikely", 0.10, 0.33, FALSE, TRUE,
  "Very unlikely", 0.05, 0.10, FALSE, TRUE,
  "Extremely unlikely", 0.01, 0.05, FALSE, TRUE,
  "Exceptionally unlikely", 0.00, 0.01, FALSE, TRUE
) %>%
  dplyr::mutate(term = forcats::fct_inorder(term))

statsnz_likelihood_scale <- ipcc_likelihood_scale %>%
  dplyr::mutate(stats_term =
                  forcats::fct_collapse(
                    term,
                    `Very likely` = c("Very likely",
                                      "Extremely likely",
                                      "Virtually certain"),
                    `Indeterminate` = c("About as likely as not"),
                    `Very unlikely` = c("Very unlikely",
                                        "Extremely unlikely",
                                        "Exceptionally unlikely"))) %>%
  dplyr::mutate(stats_term = forcats::fct_reorder(stats_term,
                                                  left_break,
                                                  .desc = TRUE)) %>%
  dplyr::group_by(stats_term) %>%
  dplyr::summarise(left_break = min(left_break),
                   right_break = max(right_break),
                   left_open = dplyr::last(left_open),
                   right_open = dplyr::first(right_open)) %>%
  dplyr::ungroup() %>%
  dplyr::rename(term = stats_term) %>%
  dplyr::select(term, tidyselect::everything()) %>%
  dplyr::arrange(term)

likelihood_terms <- list(
  ipcc = as.character(ipcc_likelihood_scale$term),
  statsnz = as.character(statsnz_likelihood_scale$term),
  statsnz_improving = c("Very likely improving",
                        "Likely improving",
                        "Indeterminate",
                        "Likely worsening",
                        "Very likely worsening"),
  statsnz_increasing = c("Very likely increasing",
                         "Likely increasing",
                         "Indeterminate",
                         "Likely decreasing",
                         "Very likely decreasing")
)

usethis::use_data(likelihood_terms, internal = TRUE, overwrite = TRUE)
usethis::use_data(ipcc_likelihood_scale, overwrite = TRUE)
usethis::use_data(statsnz_likelihood_scale, overwrite = TRUE)