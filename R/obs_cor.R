#' Observational correlations between traits
#'
#' @param trait name of the trait, e.g. "body mass index"
#' @param pval_threshold pvalue threshold
#' @inheritParams mr
#'
#' @return Data from `obs_cor`
#'
#' @examples
#' obs_cor(trait = "Body mass index (BMI)") %>%
#'   dplyr::glimpse()
#'
#' # Use a different threshold
#' obs_cor(trait = "Body mass index (BMI)", pval_threshold = 1e-8) %>%
#'   dplyr::glimpse()
#' @export
obs_cor <- function(trait, pval_threshold = 1e-5, mode = c("table", "raw")) {
  mode <- match.arg(mode)
  response <- obs_cor_requests(trait = trait, pval_threshold = pval_threshold)
  if (mode == "table") {
    return(obs_cor_table(response))
  }
  httr::content(response, as = "parsed", encoding = "utf-8")
}

#' Requests /obs_cor
#'
#' @inheritParams obs_cor
#'
#' @keywords internal
obs_cor_requests <- function(trait, pval_threshold) {
  url <- getOption("epigraphdb.api.url") # nolint
  query <- list(
    trait = trait,
    pval_threshold = pval_threshold
  )
  httr::GET(glue::glue("{url}/obs_cor"), query = query)
}

#' Table format /obs_cor
#'
#' @param response response from `obs_cor_requests`
#'
#' @keywords internal
obs_cor_table <- function(response) {
  response %>%
    httr::content(as = "text", encoding = "utf-8") %>%
    jsonlite::fromJSON(flatten = TRUE) %>%
    purrr::pluck("results") %>%
    tibble::as_tibble()
}
