#' Literature evidence regarding a GWAS trait
#'
#' @param trait A trait name
#' @param semmed_predicate Either NULL which returns entries from
#' all predicates, or a SemMed predicate e.g. "DIAGNOSES" or "ASSOCIATED_WITH"
#' @inheritParams mr
#' @return Data from
#' `/literature/gwas`
#'
#' @examples
#' literature_gwas(trait = "Body mass index")
#' @export
literature_gwas <- function(trait, semmed_predicate = NULL,
                            mode = c("table", "raw")) {
  mode <- match.arg(mode)
  response <- api_request(
    endpoint = "/literature/gwas",
    params = list(
      trait = trait,
      semmed_predicate = semmed_predicate
    ),
    mode = mode
  )
  response
}
