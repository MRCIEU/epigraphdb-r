#' GWAS correlations between traits
#'
#' @param trait name of the trait, e.g. "body mass index"
#' @param cor_coef_threshold correlation coefficient threshold
#' @inheritParams mr
#'
#' @return Data from
#' [
#'   `/gwas_cor`
#' ](http://api.epigraphdb.org/#/topics/get_gwas_cor_gwas_cor_get)
#'
#' @examples
#' gwas_cor(trait = "Body mass index") %>%
#'   dplyr::glimpse()
#'
#' # Use a different threshold
#' gwas_cor(trait = "Body mass index", cor_coef_threshold = 0.4) %>%
#'   dplyr::glimpse()
#' @export
gwas_cor <- function(trait, cor_coef_threshold = 0.8,
                     mode = c("table", "raw")) {
  mode <- match.arg(mode)
  response <- api_get_request(
    endpoint = "/gwas_cor",
    params = list(
      trait = trait,
      cor_coef_threshold = cor_coef_threshold
    )
  )
  if (mode == "table") {
    return(gwas_cor_table(response))
  }
  httr::content(response, as = "parsed", encoding = "utf-8")
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
