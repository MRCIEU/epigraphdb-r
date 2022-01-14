#' MR evidence on confounding traits between exposure and outcome
#'
#' [`GET /confounder`](https://docs.epigraphdb.org/api/api-endpoints/#get-confounder)
#'
#' @param type One in `["confounder", "intermediate",
#' "reverse_intermediate", "collider"]`
#' Refer to [
#'   the confounder view in web application
#' ](https://epigraphdb.org/confounder)
#' for details
#' @inheritParams mr
#'
#' @return Data from `GET /confounder`
#'
#' @examples
#' \dontrun{
#' confounder(exposure_trait = "Body mass index", outcome_trait = "Coronary heart disease")
#' }
#' @export
confounder <- function(exposure_trait = NULL, outcome_trait = NULL,
                       type = c(
                         "confounder", "intermediate",
                         "reverse_intermediate", "collider"
                       ),
                       pval_threshold = 0.00001,
                       mode = c("table", "raw")) {
  mode <- match.arg(mode)
  type <- match.arg(type)
  response <- query_epigraphdb(
    route = "/confounder",
    params = list(
      exposure_trait = exposure_trait, outcome_trait = outcome_trait,
      type = type,
      pval_threshold = pval_threshold
    ),
    mode = mode
  )
  response
}
