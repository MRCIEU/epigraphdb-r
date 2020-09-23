#' Return protein uniprot_id from associated genes
#'
#' [`POST /mappings/gene-to-protein`](https://docs.epigraphdb.org/api/api-endpoints/#post-mappingsgene-to-protein)
#'
#' @param gene_name_list
#' List of HGNC symbols of the genes (default)
#' @param gene_id_list
#' List of Ensembl gene IDs (when `by_gene_id == TRUE`)
#' @param by_gene_id
#' Search for gene ids (Ensembl gene IDs) instead of gene names (HGNC symbols)
#' @inheritParams mr
#'
#' @return Data from `POST /mappings/gene-to-protein`
#' @export
#'
#' @examples
#' # By HGNC symbols
#' mappings_gene_to_protein(gene_name_list = c("GCH1", "MYOF"))
#'
#' # By Enselbl Ids
#' mappings_gene_to_protein(gene_id_list = c("ENSG00000162594", "ENSG00000113302"), by_gene_id = TRUE)
mappings_gene_to_protein <- function(gene_name_list = NULL, gene_id_list = NULL,
                                     by_gene_id = FALSE,
                                     mode = c("table", "raw")) {
  mode <- match.arg(mode)
  # Resolve singletons
  if (!is.null(gene_name_list)) {
    gene_name_list <- I(gene_name_list)
  } else {
    gene_name_list <- list()
  }
  if (!is.null(gene_id_list)) {
    gene_id_list <- I(gene_id_list)
  } else {
    gene_id_list <- list()
  }
  response <- query_epigraphdb(
    route = "/mappings/gene-to-protein",
    params = list(
      gene_name_list = gene_name_list,
      gene_id_list = gene_id_list,
      by_gene_id = by_gene_id
    ),
    mode = mode,
    method = "POST"
  )
  response
}
