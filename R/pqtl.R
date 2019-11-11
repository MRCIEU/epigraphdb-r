#' Return information related to the pQTL analysis
#'
#' @param query
#' (Required) A protein coding gene name or a trait name,
#' eg. "ADAM19" or "Inflammatory bowel disease"
#' which cannot be `NULL`.
#' @param rtype
#' (Optional) A type of data to be extracted, which can be one of these options:
#' 1. `simple`: Basic summary
#' 2. `mrres`: MR results (DEFAULT)
#' 3. `sglmr`: Single SNP MR results
#' 4. `inst`: SNP information
#' 5. `sense`: Sensitivity analysis
#' **NOTE**: `mrres` is a DEFAULT option.
#' @param pvalue
#' (Optional) A pvalue threshold for MR results with the DEFAULT set to 0.05.
#' **NOTE**: this threshold applies to any `rtype` chosen.
#' @param searchflag
#' (Required) A flag to indicate whether you are searching for proteins or
#' traits which cannot be `NULL`.
#' If `query` is a protein name, then this flag should be "proteins";
#' if `query` is a trait, this flag should be "traits".
#' **NOTE**: if the wrong flag is chosen for `query`, there will be no result
#' returned.
#' @inheritParams mr
#'
#' @return Data from `pqtl`
#'
#' @examples
#' # Returns a data frame of MR results, while searching for proteins
#' pqtl(query = "ADAM19", searchflag = "proteins")
#'
#' # Returns a data frame with SNP information, while searching for traits
#' pqtl(
#'   query = "Inflammatory bowel disease",
#'   rtype = "inst",
#'   searchflag = "traits"
#' )
#'
#' # Change a pvalue threshold (the default is 0.05)
#' pqtl(
#'   query = "Inflammatory bowel disease",
#'   rtype = "inst",
#'   pvalue = 1.0,
#'   searchflag = "traits"
#' )
#'
#' # Returns raw response if mode="raw"
#' pqtl(
#'   query = "ADAM19", searchflag = "proteins",
#'   mode = "raw"
#' ) %>% str()
#' @export
pqtl <- function(query = NULL,
                 rtype = "mrres", pvalue = 0.05, searchflag = NULL,
                 mode = c("table", "raw")) {
  mode <- match.arg(mode)
  pqtl_regulator(query, rtype, pvalue, searchflag)
  response <- pqtl_requests(
    query = query,
    rtype = rtype,
    pvalue = pvalue,
    searchflag = searchflag
  )
  if (mode == "table" && length(response) > 0) {
    return(pqtl_table(response))
  }
  response
}


#' Return information related to the pleiotropy of SNPs
#'
#' @param rsid
#' (Required) A SNP identified by rsID which cannot be `NULL`.
#' @param prflag
#' (Optional) A flag which determines whether the number (if "count")
#' or names (if "proteins") of the associated proteins should be returned.
#' The DEFAULT value is "proteins".
#' @param mode
#' (Optional) If `mode = "table"`, returns a data frame
#' (a [`tibble`](https://tibble.tidyverse.org/) as per
#' [`tidyverse`](https://style.tidyverse.org/) convention).
#' If `mode = "raw"`, returns a raw response from EpiGraphDB API
#' with minimal parsing done by [`httr`](https://httr.r-lib.org/).
#'
#' @export
#'
#' @examples
#'
#' # Returns a data frame of associated proteins
#' pqtl_pleio(rsid = "rs1260326")
#'
#' # Returns a number of associated proteins
#' pqtl_pleio(rsid = "rs1260326", prflag = "count")
pqtl_pleio <- function(rsid = NULL,
                       prflag = "proteins",
                       mode = c("table", "raw")) {
  mode <- match.arg(mode)
  pqtl_pleio_regulator(rsid, prflag)
  response <- pqtl_pleio_requests(
    rsid = rsid,
    prflag = prflag
  )

  if (mode == "table" && length(response) > 0 &&
    prflag == "proteins") {
    return(pqtl_table(response))
  }
  response
}


#' Return a list of all proteins/exposures or traits/outcomes
#' available in the database
#'
#' @param flag
#' (Optional) A flag which indicates whether the list of
#' exposures (if "exposures") or outcomes (if "outcomes")
#' should be returned. The DEFAULT is "exposures".
#' @inheritParams mr
#'
#' @export
#'
#' @examples
#'
#' # Returns a list of available proteins (exposures)
#' pqtl_list()
#'
#' # Returns a list of available traits (outcomes)
#' pqtl_list(flag = "outcomes")
pqtl_list <- function(flag = "exposures",
                      mode = c("table", "raw")) {
  mode <- match.arg(mode)

  if (is.null(flag) || !(flag %in% c("exposures", "outcomes"))) {
    stop("flag has invalid value, should be 'exposures' or 'outcomes'.")
  } else {
    response <- pqtl_list_requests(flag = flag)
  }

  if (mode == "table" && length(response) > 0) {
    return(pqtl_table(response))
  }
  response
}


#' Regulate parameter input
#'
#' @inheritParams pqtl
#'
#' @keywords internal
pqtl_regulator <- function(query, rtype, pvalue, searchflag) {
  if (is.null(query) || is.null(searchflag)) {
    stop(glue::glue(
      "query and searchflag cannot be NULL, ",
      "try query='ADAM19' and searchflag='proteins' ",
      "or query='Inflammatory bowel disease' and searchflag='traits'."
    ))
  }

  if (is.null(rtype) || is.null(pvalue)) {
    stop(glue::glue(
      "rtype or pvalue cannot be NULL, specify their value or use the default."
    ))
  }

  if (!(searchflag %in% c("proteins", "traits"))) {
    stop(glue::glue(
      "searchflag has invalid value, should be 'proteins' or 'traits'."
    ))
  }

  if (!(rtype %in% c("simple", "mrres", "sglmr", "inst", "sense"))) {
    stop(glue::glue(
      "rtype has invalid value, should be one of: ",
      "'simple', 'mrres', 'sglmr', 'inst' or 'sense'."
    ))
  }

  if ((pvalue < 0.0) || (pvalue > 1.0)) {
    stop("pvalue threshold has invalid value, should be in [0,1].")
  }
}


#' Create an API request for the pQTL-related analyses
#'
#' @inheritParams pqtl
#'
#' @keywords internal
pqtl_requests <- function(query, rtype, pvalue, searchflag) {
  url <- getOption("epigraphdb.api.url") # nolint
  r <- httr::GET(glue::glue("{url}/pqtl/"),
    query = list(
      query = query,
      rtype = rtype,
      pvalue = pvalue,
      searchflag = searchflag
    )
  )
  r %>%
    httr::content(encoding = "utf-8") %>%
    purrr::pluck("results")
}


#' Regulate parameter input
#'
#' @inheritParams pqtl_pleio
#'
#' @keywords internal
pqtl_pleio_regulator <- function(rsid, prflag) {
  if (!(prflag %in% c("proteins", "count")) || is.null(prflag)) {
    stop("prflag has invalid value, should be 'proteins' or 'count'.")
  }

  if (is.null(rsid)) {
    stop("rsid cannot be NULL, specify its value such as rs1260326.")
  }
}


#'  Create an API request for the pleiotropy analyses
#'
#' @inheritParams pqtl
#'
#' @return
#' @keywords internal
pqtl_pleio_requests <- function(rsid, prflag) {
  url <- getOption("epigraphdb.api.url") # nolint
  r <- httr::GET(glue::glue("{url}/pqtl/pleio/"),
    query = list(
      rsid = rsid,
      prflag = prflag
    )
  )
  r %>%
    httr::content(encoding = "utf-8") %>%
    purrr::pluck("results")
}


#'  Create an API request for the list of proteins/traits
#'
#' @inheritParams pqtl_list
#'
#' @keywords internal
pqtl_list_requests <- function(flag) {
  url <- getOption("epigraphdb.api.url") # nolint
  r <- httr::GET(glue::glue("{url}/pqtl/list/"),
    query = list(flag = flag)
  )
  r %>%
    httr::content(encoding = "utf-8") %>%
    purrr::pluck("results")
}


#' Reformat reponse from pQTL results into a table
#'
#' @param response response for pQTL analysis
#'
#' @keywords internal
pqtl_table <- function(response) {
  response %>%
    purrr::transpose() %>%
    tibble::as_tibble() %>%
    dplyr::mutate_all(unlist)
}
