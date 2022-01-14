#' For the list of proteins, returns their associated pathway data
#'
#' [`POST /protein/in-pathway`](https://docs.epigraphdb.org/api/api-endpoints/#post-proteinin-pathway)
#'
#' @param uniprot_id_list
#' A list of protein UniProt IDs
#' @inheritParams mr
#'
#' @return Data from `POST /protein/in-pathway`
#' @export
#'
#' @examples
#' \dontrun{
#' protein_in_pathway(uniprot_id_list = c("014933", "060674", "P32455"))
#' }
protein_in_pathway <- function(uniprot_id_list, mode = c("table", "raw")) {
  mode <- match.arg(mode)
  response <- query_epigraphdb(
    route = "/protein/in-pathway",
    params = list(
      # guard against auto unpacking of singletons
      uniprot_id_list = I(uniprot_id_list)
    ),
    mode = mode,
    method = "POST"
  )
  response
}
