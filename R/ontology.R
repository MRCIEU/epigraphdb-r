#' Ontology association between EFO term and Gwas
#'
#' @param efo_term EFO term, e.g. "systolic blood pressure"
#' @inheritParams mr
#'
#' @return Data from
#' [
#'   `ontology`
#' ](http://api.epigraphdb.org/#/topics/get_ontology_ontology_get)
#'
#' @examples
#' ontology(efo_term = "systolic blood pressure")
#' @export
ontology <- function(efo_term, mode = c("table", "raw")) {
  mode <- match.arg(mode)
  response <- api_get_request(
    endpoint = "/ontology",
    params = list(efo_term = efo_term)
  )
  if (mode == "table") {
    return(ontology_table(response))
  }
  httr::content(response, as = "parsed", encoding = "utf-8")
}

#' Table format /ontology
#'
#' @param response response from `ontology_requests`
#'
#' @keywords internal
ontology_table <- function(response) {
  response %>%
    httr::content(as = "text", encoding = "utf-8") %>%
    jsonlite::fromJSON(flatten = TRUE) %>%
    purrr::pluck("results") %>%
    tibble::as_tibble()
}
