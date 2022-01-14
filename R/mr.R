#' Return information related to Mendelian Randomisation
#'
#' [`GET /mr`](https://docs.epigraphdb.org/api/api-endpoints/#get-mr)
#'
#' @param exposure_trait
#' A trait name, e.g. "Body mass index",
#' leaving `exposure_trait` as `NULL` will return MR information
#' related to a specific `outcome`.
#' **NOTE**: `exposure_trait` and `outcome_trait` cannot be both `NULL`.
#' @param outcome_trait
#' A trait name, e.g. "Coronary heart disease",
#' leaving `outcome_trait` as `NULL` will return MR information
#' related to a specific `exposure_trait`.
#' **NOTE**: `exposure_trait` and `outcome_trait` cannot be both `NULL`.
#' @param pval_threshold
#' P-value threshold
#' @param mode
#' If `mode = "table"`, returns a data frame
#' (a [`tibble`](https://tibble.tidyverse.org/) as per
#' [`tidyverse`](https://style.tidyverse.org/) convention).
#' If `mode = "raw"`, returns a raw response from EpiGraphDB API
#' with minimal parsing done by [`httr`](https://httr.r-lib.org/).
#'
#' @return Data from `GET /mr`
#'
#' @examples
#' # Returns a data frame
#' \dontrun{
#' mr(exposure_trait = "Body mass index", outcome_trait = "Coronary heart disease")
#' }
#'
#' # Returns raw response
#' \dontrun{
#' mr(
#'   exposure_trait = "Body mass index", outcome_trait = "Coronary heart disease",
#'   mode = "raw"
#' ) %>% str()
#' }
#'
#' # Use a different threshold
#' \dontrun{
#' mr(exposure_trait = "Body mass index", pval_threshold = 1e-8)
#' }
#' @export
mr <- function(exposure_trait = NULL, outcome_trait = NULL,
               pval_threshold = 1e-5,
               mode = c("table", "raw")) {
  mode <- match.arg(mode)
  response <- query_epigraphdb(
    route = "/mr",
    params = list(
      exposure_trait = exposure_trait, outcome_trait = outcome_trait,
      pval_threshold = pval_threshold
    ),
    mode = mode
  )
  response
}
