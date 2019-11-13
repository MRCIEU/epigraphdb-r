#' Observational correlations between traits
#'
#' @param trait name of the trait, e.g. "body mass index"
#' @param pval_threshold pvalue threshold
#' @inheritParams mr
#'
#' @return Data from
#' [
#'   `/obs_cor`
#' ](http://api.epigraphdb.org/#/topics/get_obs_cor_obs_cor_get)
#'
#' @examples
#' obs_cor(trait = "Body mass index (BMI)") %>%
#'   dplyr::glimpse()
#'
#' # Use a different threshold
#' obs_cor(trait = "Body mass index (BMI)", pval_threshold = 1e-8) %>%
#'   dplyr::glimpse()
#' @export
obs_cor <- function(trait, pval_threshold = 1e-5, mode = c("table", "raw")) {
  mode <- match.arg(mode)
  response <- api_get_request(
    endpoint = "/obs_cor",
    params = list(
      trait = trait, pval_threshold = pval_threshold
    )
  )
  if (mode == "table") {
    return(flatten_response(response))
  }
  httr::content(response, as = "parsed", encoding = "utf-8")
}
