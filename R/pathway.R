#' Pathway evidence
#'
#' [`GET /pathway`](https://docs.epigraphdb.org/api/api-endpoints/#get-pathway)
#'
#' @param trait A trait name
#' @inheritParams mr
#' @return Data from `GET /pathway`
#'
#' @examples
#' \dontrun{
#' pathway(trait = "Body mass index")
#' }
#' @export
pathway <- function(trait,
                    pval_threshold = 0.00001,
                    mode = c("table", "raw")) {
  mode <- match.arg(mode)
  response <- query_epigraphdb(
    route = "/pathway",
    params = list(
      trait = trait,
      pval_threshold = pval_threshold
    ),
    mode = mode
  )
  response
}
