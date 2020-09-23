#' Return information related to the pQTL analysis
#'
#' [`GET /pqtl/`](https://docs.epigraphdb.org/api/api-endpoints/#get-pqtl)
#'
#' @param query
#' (Required) A protein coding gene name or a trait name,
#' e.g. "ADAM19" or "Inflammatory bowel disease"
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
#' @return Data from `GET /pqtl/`
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
pqtl <- function(query,
                 rtype = c("mrres", "simple", "sglmr", "inst", "sense"),
                 pvalue = 0.05,
                 searchflag = c("traits", "proteins"),
                 mode = c("table", "raw")) {
  mode <- match.arg(mode)
  rtype <- match.arg(rtype)
  searchflag <- match.arg(searchflag)
  response <- query_epigraphdb(
    route = "/pqtl/",
    params = list(
      query = query,
      rtype = rtype,
      pvalue = pvalue,
      searchflag = searchflag
    ),
    mode = mode
  )
  response
}


#' Return information related to the pleiotropy of SNPs
#'
#' [`GET /pqtl/pleio/`](https://docs.epigraphdb.org/api/api-endpoints/#get-pqtlpleio)
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
#' @return Data from `GET /pqtl/pleio/`
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
                       prflag = c("proteins", "count"),
                       mode = c("table", "raw")) {
  mode <- match.arg(mode)
  prflag <- match.arg(prflag)
  response <- query_epigraphdb(
    route = "/pqtl/pleio/",
    params = list(
      rsid = rsid,
      prflag = prflag
    ),
    mode = mode
  )
  # special cases
  if (prflag == "count") {
    response <- as.integer(response)
  }
  response
}


#' Return a list of all proteins/exposures or traits/outcomes
#' available in the database
#'
#' [`GET /pqtl/list/`](https://docs.epigraphdb.org/api/api-endpoints/#get-pqtllist)
#'
#' @param flag
#' (Optional) A flag which indicates whether the list of
#' exposures (if "exposures") or outcomes (if "outcomes")
#' should be returned. The DEFAULT is "exposures".
#' @inheritParams mr
#'
#' @return Data from `GET /pqtl/list/`
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
pqtl_list <- function(flag = c("exposures", "outcomes"),
                      mode = c("table", "raw")) {
  mode <- match.arg(mode)
  flag <- match.arg(flag)
  response <- query_epigraphdb(
    route = "/pqtl/list/",
    params = list(flag = flag),
    mode = mode
  )
  response
}
