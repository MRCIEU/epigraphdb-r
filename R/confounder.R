#' MR evidence on confounding traits between exposure and outcome
#'
#' @param type One in `["confounder", "intermediate",
#' "reverse_intermediate", "collider"]`
#' Refer to [
#'   the confounder view in web application
#' ](http://epigraphdb.org/confounder)
#' for details
#' @inheritParams mr
#'
#' @return Data from
#' [
#'   `/confounder`
#' ](http://api.epigraphdb.org/#/topics/get_confounder_confounder_get)
#'
#' @examples
#' confounder(exposure = "Body mass index", outcome = "Coronary heart disease")
#' @export
confounder <- function(exposure = NULL, outcome = NULL,
                       type = c(
                         "confounder", "intermediate",
                         "reverse_intermediate", "collider"
                       ),
                       pval_threshold = 0.00001,
                       mode = c("table", "raw")) {
  mode <- match.arg(mode)
  type <- match.arg(type)
  response <- api_request(
    endpoint = "/confounder",
    params = list(
      exposure = exposure, outcome = outcome,
      type = type,
      pval_threshold = pval_threshold
    ),
    mode = mode
  )
  response
}
