#' Drugs for risk factors
#'
#' [`GET /drugs/risk-factors`](https://docs.epigraphdb.org/api/api-endpoints/#get-drugsrisk-factors)
#'
#' @param trait A trait name
#' @inheritParams mr
#' @return Data from `GET /drugs/risk-factors`
#'
#' @examples
#' drugs_risk_factors(trait = "Body mass index")
#' @export
drugs_risk_factors <- function(trait, pval_threshold = 1e-8,
                               mode = c("table", "raw")) {
  mode <- match.arg(mode)
  response <- query_epigraphdb(
    route = "/drugs/risk-factors",
    params = list(
      trait = trait,
      pval_threshold = pval_threshold
    ),
    mode = mode
  )
  response
}
