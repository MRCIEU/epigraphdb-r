#' Observational correlations between traits
#'
#' [`GET /obs-cor`](https://docs.epigraphdb.org/api/api-endpoints/#get-obs-cor)
#'
#' @param trait name of the trait, e.g. "body mass index"
#' @param cor_coef_threshold correlation coefficient threshold
#' @inheritParams mr
#'
#' @return Data from `GET /obs-cor`
#'
#' @examples
#' \dontrun{
#' obs_cor(trait = "Body mass index (BMI)") %>%
#'   dplyr::glimpse()
#' }
#'
#' # Use a different threshold
#' \dontrun{
#' obs_cor(trait = "Body mass index (BMI)", cor_coef_threshold = 0.8) %>%
#'   dplyr::glimpse()
#' }
#' @export
obs_cor <- function(trait, cor_coef_threshold = 0.8, mode = c("table", "raw")) {
  mode <- match.arg(mode)
  response <- query_epigraphdb(
    route = "/obs-cor",
    params = list(
      trait = trait, cor_coef_threshold = cor_coef_threshold
    ),
    mode = mode
  )
  response
}
