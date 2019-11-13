#' Literature evidence regarding MR
#'
#' @param trait_name A trait name
#' @param semmed_predicate Either NULL which returns entries from
#' all predicates, or a SemMed predicate e.g. "DIAGNOSES" or "ASSOCIATED_WITH"
#' @inheritParams mr
#' @return Data from
#' [
#'   `/literature/mr`
#' ](http://api.epigraphdb.org/#/literature/get_literature_mr_literature_mr_get)
#'
#' @examples
#' literature_mr(trait_name = "Body mass index")
#' @export
literature_mr <- function(trait_name, semmed_predicate = NULL,
                          mode = c("table", "raw")) {
  mode <- match.arg(mode)
  response <- api_request(
    endpoint = "/literature/mr",
    params = list(
      trait_name = trait_name,
      semmed_predicate = semmed_predicate
    ),
    mode = mode
  )
  response
}
