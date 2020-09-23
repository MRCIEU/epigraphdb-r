#' Multi SNP QTL MR evidence
#'
#' [`GET /xqtl/multi-snp-mr`](https://docs.epigraphdb.org/api/api-endpoints/#get-xqtlmulti-snp-mr)
#'
#' @param exposure_gene Name of the exposure gene
#' @param outcome_trait Name of the outcome trait
#' @param mr_method "IVW" or "Egger"
#' @param qtl_type "eQTL" or "pQTL"
#' @inheritParams mr
#' @return Data from `GET /xqtl/multi-snp-mr`
#'
#' @examples
#' xqtl_multi_snp_mr(outcome_trait = "Coronary heart disease")
#' @export
xqtl_multi_snp_mr <- function(exposure_gene = NULL, outcome_trait = NULL,
                              mr_method = c("IVW", "Egger"),
                              qtl_type = c("eQTL", "pQTL"),
                              pval_threshold = 1e-5,
                              mode = c("table", "raw")) {
  mode <- match.arg(mode)
  mr_method <- match.arg(mr_method)
  qtl_type <- match.arg(qtl_type)
  response <- query_epigraphdb(
    route = "/xqtl/multi-snp-mr",
    params = list(
      exposure_gene = exposure_gene,
      outcome_trait = outcome_trait,
      mr_method = mr_method,
      qtl_type = qtl_type,
      pval_threshold = pval_threshold
    ),
    mode = mode
  )
  response
}

#' Single SNP QTL MR evidence
#'
#' [`GET /xqtl/single-snp-mr`](https://docs.epigraphdb.org/api/api-endpoints/#get-xqtlsingle-snp-mr)
#'
#' @param snp SNP rsid
#' @inheritParams xqtl_multi_snp_mr
#' @return Data from `GEET /xqtl/single-snp-mr`
#'
#' @examples
#' xqtl_single_snp_mr(outcome_trait = "Coronary heart disease")
#' @export
xqtl_single_snp_mr <- function(exposure_gene = NULL, outcome_trait = NULL,
                               snp = NULL,
                               qtl_type = c("eQTL", "pQTL"),
                               pval_threshold = 1e-5,
                               mode = c("table", "raw")) {
  mode <- match.arg(mode)
  qtl_type <- match.arg(qtl_type)
  response <- query_epigraphdb(
    route = "/xqtl/single-snp-mr",
    params = list(
      exposure_gene = exposure_gene,
      outcome_trait = outcome_trait,
      snp = snp,
      qtl_type = qtl_type,
      pval_threshold = pval_threshold
    ),
    mode = mode
  )
  response
}
