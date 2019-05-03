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
#' @param mode
#' If `mode = "table"`, returns a data frame
#' (a [`tibble`](https://tibble.tidyverse.org/) as per
#' [`tidyverse`](https://style.tidyverse.org/) convention).
#' If `mode = "raw"`, returns a raw response from EpiGraphDB API
#' with minimal parsing done by [`httr`](https://httr.r-lib.org/).
#'
#' @export
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
mr <- function(exposure = NULL, outcome = NULL,
               mode = c("table", "raw")) {
  mode <- match.arg(mode)
  mr_regulator(exposure, outcome)
  response <- mr_requests(exposure = exposure, outcome = outcome)
  if (mode == "table") {
    return(mr_table(response))
  }
  response %>% httr::content(as = "parsed")
}

#' Regulate parameter input
#'
#' @param exposure
#' @param outcome
#'
#' @return
#' @keywords internal
mr_regulator <- function(exposure, outcome) {
  if (is.null(exposure) && is.null(outcome)) {
    stop("exposure and outcome cannot be both NULL!")
  }
}

#' The core function to query from epigraphdb api
#'
#' @param exposure
#' @param outcome
#'
#' @return
#' @keywords internal
mr_requests <- function(exposure, outcome) {
  # nolint start (unused variable)
  url <- getOption("epigraphdb.api.url")
  # nolint end
  query <- list(
    exposure = exposure,
    outcome = outcome
  )
  httr::GET(glue::glue("{url}/mr"), query = query)
}

#' Reformat reponse from mr into a table
#'
#' @param response response from mr
#'
#' @return
#' @keywords internal
mr_table <- function(response) {
  response %>%
    httr::content(as = "text") %>%
    jsonlite::fromJSON(flatten = TRUE) %>%
    purrr::pluck("results") %>%
    tibble::as_tibble()
}