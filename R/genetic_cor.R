#' Genetic correlations between traits
#'
#' [`GET /genetic-cor`](https://docs.epigraphdb.org/api/api-endpoints/#get-genetic-cor)
#'
#' @inheritParams obs_cor
#'
#' @return Data from `GET /genetic_cor`
#'
#' @examples
#' \dontrun{
#' genetic_cor(trait = "Body mass index") %>%
#'   dplyr::glimpse()
#' }
#'
#' # Use a different threshold
#' \dontrun{
#' genetic_cor(trait = "Body mass index", cor_coef_threshold = 0.4) %>%
#'   dplyr::glimpse()
#' }
#' @export
genetic_cor <- function(trait, cor_coef_threshold = 0.8,
                        mode = c("table", "raw")) {
  mode <- match.arg(mode)
  response <- query_epigraphdb(
    route = "/genetic-cor",
    params = list(
      trait = trait, cor_coef_threshold = cor_coef_threshold
    ),
    mode = mode
  )
  response
}
