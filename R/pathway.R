#' Pathway evidence
#'
#' @param trait A trait name
#' @inheritParams mr
#' @return Data from
#' [
#'   `/pathway`
#' ](http://api.epigraphdb.org/#/topics/get_confounder_pathway_get)
#'
#' @examples
#' pathway(trait = "Body mass index")
#' @export
pathway <- function(trait,
                    pval_threshold = 0.00001,
                    mode = c("table", "raw")) {
  mode <- match.arg(mode)
  response <- api_request(
    endpoint = "/pathway",
    params = list(
      trait = trait,
      pval_threshold = pval_threshold
    ),
    mode = mode
  )
  response
}
