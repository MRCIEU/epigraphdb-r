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
  response <- api_request(
    endpoint = "/ontology",
    params = list(efo_term = efo_term),
    mode = mode
  )
  response
}
