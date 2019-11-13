#' Drugs for risk factors
#'
#' @param trait A trait name
#' @inheritParams mr
#' @return Data from
#' [
#'   `/drugs/risk-factors`
#' ](http://api.epigraphdb.org/#/drugs/get_drug_risk_factors_drugs_risk-factors_get)
#'
#' @examples
#' drugs_risk_factors(trait = "Body mass index")
#' @export
drugs_risk_factors <- function(trait, pval_threshold = 1e-8,
                               mode = c("table", "raw")) {
  mode <- match.arg(mode)
  response <- api_request(
    endpoint = "/drugs/risk-factors",
    params = list(
      trait = trait,
      pval_threshold = pval_threshold
    ),
    mode = mode
  )
  response
}
