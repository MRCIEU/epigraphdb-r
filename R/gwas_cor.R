#' GWAS correlations between traits
#'
#' @param trait name of the trait, e.g. "body mass index"
#' @param cor_coef_threshold correlation coefficient threshold
#' @inheritParams mr
#'
#' @return Data from `gwas_cor`
#'
#' @examples
#' gwas_cor(trait = "Body mass index") %>%
#'   dplyr::glimpse()
#'
#' # Use a different threshold
#' gwas_cor(trait = "Body mass index", cor_coef_threshold = 0.4) %>%
#'   dplyr::glimpse()
#'
#' @export
gwas_cor <- function(trait, cor_coef_threshold = 0.8,
                     mode = c("table", "raw")) {
  mode <- match.arg(mode)
  response <- gwas_cor_requests(
    trait = trait,
    cor_coef_threshold = cor_coef_threshold
  )
  if (mode == "table") {
    return(gwas_cor_table(response))
  }
  httr::content(response, as = "parsed", encoding = "utf-8")
}

#' Requests /gwas_cor
#'
#' @inheritParams gwas_cor
#'
#' @keywords internal
gwas_cor_requests <- function(trait, cor_coef_threshold) {
  url <- getOption("epigraphdb.api.url") # nolint
  query <- list(
    trait = trait,
    cor_coef_threshold = cor_coef_threshold
  )
  httr::GET(glue::glue("{url}/gwas_cor"), query = query)
}

#' Table format /gwas_cor
#'
#' @param response response from `gwas_cor_requests`
#'
#' @keywords internal
gwas_cor_table <- function(response) {
  response %>%
    httr::content(as = "text", encoding = "utf-8") %>%
    jsonlite::fromJSON(flatten = TRUE) %>%
    purrr::pluck("results") %>%
    tibble::as_tibble()
}
