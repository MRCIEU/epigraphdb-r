#' GWAS correlations between traits
#'
#' @param trait name of the trait, e.g. "body mass index"
#' @param cor_coef_threshold correlation coefficient threshold
#' @inheritParams mr
#'
#' @return
#' @export
#'
#' @examples
#' gwas_cor(trait = "body mass index")
gwas_cor <- function(trait, cor_coef_threshold = 0.8, mode = c("table", "raw")) {
  mode <- match.arg(mode)
  response <- gwas_cor_requests(trait = trait, cor_coef_threshold = cor_coef_threshold)
  if (mode == "table") {
    return(gwas_cor_table(response))
  }
  httr::content(response, as = "parsed")
}

#' Requests /gwas_cor
#'
#' @inheritParams gwas_cor
#'
#' @return
#' @keywords internal
gwas_cor_requests <- function(trait, cor_coef_threshold) {
  # nolint start (unused variable)
  url <- getOption("epigraphdb.api.url")
  # nolint end
  query <- list(
    trait = trait,
    cor_coef_threshold = cor_coef_threshold
  )
  httr::GET(glue::glue("{url}/gwas_cor"), query = query)
}

#' Title
#'
#' @param response response from `gwas_cor_requests`
#'
#' @return
#' @keywords internal
gwas_cor_table <- function(response) {
  response %>%
    httr::content(as = "text") %>%
    jsonlite::fromJSON(flatten = TRUE) %>%
    purrr::pluck("results") %>%
    tibble::as_tibble()
}
