#' Ontology association between EFO term and Gwas
#'
#' @param efo_term EFO term, e.g. "systolic blood pressure"
#' @inheritParams mr
#'
#' @return
#' @export
#'
#' @examples
#' ontology(efo_term = "systolic blood pressure")
ontology <- function(efo_term, mode = c("table", "raw")) {
  mode <- match.arg(mode)
  response <- ontology_requests(efo_term = efo_term)
  if (mode == "table") {
    return(ontology_table(response))
  }
  httr::content(response, as = "parsed", encoding = "utf-8")
}

#' Requests /ontology
#'
#' @inheritParams ontology
#'
#' @return
#' @keywords internal
ontology_requests <- function(efo_term) {
  # nolint start (unused variable)
  url <- getOption("epigraphdb.api.url")
  # nolint end
  query <- list(
    efo_term = efo_term
  )
  httr::GET(glue::glue("{url}/ontology"), query = query)
}

#' Table format /ontology
#'
#' @param response response from `ontology_requests`
#'
#' @return
#' @keywords internal
ontology_table <- function(response) {
  response %>%
    httr::content(as = "text", encoding = "utf-8") %>%
    jsonlite::fromJSON(flatten = TRUE) %>%
    purrr::pluck("results") %>%
    tibble::as_tibble()
}
