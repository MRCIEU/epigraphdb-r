#' Pathway evidence
#'
#' @param trait_name A trait name
#' @inheritParams mr
#' @return Data from
#' [
#'   `/pathway`
#' ](http://api.epigraphdb.org/#/topics/get_confounder_pathway_get)
#'
#' @examples
#' pathway(trait_name = "Body mass index")
#' @export
pathway <- function(trait_name,
                    pval_threshold = 0.00001,
                    mode = c("table", "raw")) {
  mode <- match.arg(mode)
  response <- api_request(
    endpoint = "/pathway",
    params = list(
      trait_name = trait_name,
      pval_threshold = pval_threshold
    ),
    mode = mode
  )
  response
}
