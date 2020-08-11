#' Send a query in Cypher to EpiGraphDB
#'
#' NOTE: this function is intended for advanced uses.
#' Regular users are recommended to use standard query functions
#'
#' @inheritParams mr
#' @param query
#' A Cypher query.
#'
#' @examples
#' cypher("MATCH (n:Gwas) RETURN n LIMIT 2")
#' @export
cypher <- function(query, mode = c("table", "raw")) {
  mode <- match.arg(mode)
  response <- query_epigraphdb(
    route = "/cypher",
    params = list(query = query),
    mode = mode,
    method = "POST"
  )
  response
}
