#' Ontology association between EFO term and Gwas
#'
#' [`GET /ontology/gwas-efo`](https://docs.epigraphdb.org/api/api-endpoints/#get-ontologygwas-efo)
#'
#' @param trait trait name, e.g. "body mass"
#' @param efo_term EFO term, e.g. "systolic blood pressure"
#' @param fuzzy whether query with exact matching (FALSE) or fuzzy matching (default, TRUE)
#' @inheritParams mr
#'
#' @return Data from `GET /ontology/gwas-efo`
#'
#' @examples
#' ontology_gwas_efo(trait = "blood", fuzzy = FALSE)
#'
#' ontology_gwas_efo(efo_term = "blood pressure", fuzzy = FALSE)
#' @export
ontology_gwas_efo <- function(trait = NULL, efo_term = NULL, fuzzy = TRUE, mode = c("table", "raw")) {
  mode <- match.arg(mode)
  response <- query_epigraphdb(
    route = "/ontology/gwas-efo",
    params = list(trait = trait, efo_term = efo_term, fuzzy = fuzzy),
    mode = mode
  )
  response
}
