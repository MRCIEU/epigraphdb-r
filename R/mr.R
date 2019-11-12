#' Return information related to Mendelian Randomisation
#'
#' @param exposure
#' A trait name, eg. "Body mass index",
#' leaving `exposure` as `NULL` will return MR information
#' related to a specific `outcome`.
#' **NOTE**: `exposure` and `outcome` cannot be both `NULL`.
#' @param outcome
#' A trait name, eg. "Coronary heart disease",
#' leaving `outcome` as `NULL` will return MR information
#' related to a specific `exposure`.
#' **NOTE**: `exposure` and `outcome` cannot be both `NULL`.
#' @param pval_threshold
#' P-value threshold for the MR evidence.
#' @param mode
#' If `mode = "table"`, returns a data frame
#' (a [`tibble`](https://tibble.tidyverse.org/) as per
#' [`tidyverse`](https://style.tidyverse.org/) convention).
#' If `mode = "raw"`, returns a raw response from EpiGraphDB API
#' with minimal parsing done by [`httr`](https://httr.r-lib.org/).
#'
#' @return Data from
#' [`/mr`](http://devapi.epigraphdb.org/#/topics/get_mr_mr_get)
#'
#' @examples
#' # Returns a data frame
#' mr(exposure = "Body mass index", outcome = "Coronary heart disease")
#'
#' # Returns raw response
#' mr(
#'   exposure = "Body mass index", outcome = "Coronary heart disease",
#'   mode = "raw"
#' ) %>% str()
#'
#' # Use a different threshold
#' mr(exposure = "Body mass index", pval_threshold = 1e-8)
#' @export
mr <- function(exposure = NULL, outcome = NULL,
               pval_threshold = 1e-5,
               mode = c("table", "raw")) {
  mode <- match.arg(mode)
  response <- api_get_request(
    endpoint = "/mr",
    params = list(
      exposure = exposure, outcome = outcome,
      pval_threshold = pval_threshold
    )
  )
  if (mode == "table") {
    return(mr_table(response))
  }
  response %>% httr::content(as = "parsed", encoding = "utf-8")
}

#' Reformat reponse from mr into a table
#'
#' @param response response from mr
#'
#' @keywords internal
mr_table <- function(response) {
  response %>%
    httr::content(as = "text", encoding = "utf-8") %>%
    jsonlite::fromJSON(flatten = TRUE) %>%
    purrr::pluck("results") %>%
    tibble::as_tibble()
}
