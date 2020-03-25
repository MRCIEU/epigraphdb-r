#' Genetic correlations between traits
#'
#' @inheritParams obs_cor
#'
#' @return Data from
#' `/genetic_cor`
#'
#' @examples
#' genetic_cor(trait = "Body mass index") %>%
#'   dplyr::glimpse()
#'
#' # Use a different threshold
#' genetic_cor(trait = "Body mass index", cor_coef_threshold = 0.4) %>%
#'   dplyr::glimpse()
#' @export
genetic_cor <- function(trait, cor_coef_threshold = 0.8,
                        mode = c("table", "raw")) {
  mode <- match.arg(mode)
  response <- api_get_request(
    endpoint = "/genetic-cor",
    params = list(
      trait = trait,
      cor_coef_threshold = cor_coef_threshold
    )
  )
  if (mode == "table") {
    return(flatten_response(response))
  }
  httr::content(response, as = "parsed", encoding = "utf-8")
}
