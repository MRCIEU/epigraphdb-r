#' List meta nodes (e.g. Gwas, Gene, etc.)
#'
#' [`GET /meta/nodes/list`](https://docs.epigraphdb.org/api/api-endpoints/#get-metanodeslist)
#'
#' @inheritParams mr
#'
#' @return Data from `GET /meta/nodes/list`
#'
#' @examples
#' \dontrun{
#' meta_nodes_list()
#' }
#' @export
meta_nodes_list <- function(mode = c("raw")) {
  # NOTE: currently response from the API does
  #       not conform with the standard response model
  mode <- match.arg(mode)
  response <- query_epigraphdb(
    route = "/meta/nodes/list",
    mode = mode
  )
  response
}

#' List meta rels (e.g. MR, etc.)
#'
#' [`GET /meta/rels/list`](https://docs.epigraphdb.org/api/api-endpoints/#get-metarelslist)
#'
#' @inheritParams mr
#'
#' @return Data from `GET /meta/rels/list`
#'
#' @examples
#' \dontrun{
#' meta_rels_list()
#' }
#' @export
meta_rels_list <- function(mode = c("raw")) {
  # NOTE: currently response from the API does
  #       not conform with the standard response model
  mode <- match.arg(mode)
  response <- query_epigraphdb(
    route = "/meta/rels/list",
    mode = mode
  )
  response
}

#' List nodes under a meta node
#'
#' [`GET /meta/nodes/{meta_node}/list`](https://docs.epigraphdb.org/api/api-endpoints/#get-metanodesmeta_nodelist)
#'
#' @inheritParams mr
#' @param meta_node
#' Name of a meta node (e.g. Gwas). Use `meta_nodes_list` to get the full list of meta nodes.
#' @param full_data
#' When False, only return the id and name fields (their specific names differ in specific nodes) for a node.
#' This is useful if you want your queries to return results faster with smaller amount of data requested.
#' @param limit
#' Max number of items to retrieve.
#' @param offset
#' Number of items to skip. Use `limit` and `offset` in combination to do pagination.
#'
#' @return Data from `GET /meta/nodes/{meta_node}/list`
#'
#' @examples
#' # List the first 5 Gwas nodes, with only id and name fields
#' \dontrun{
#' meta_nodes_list_node(meta_node = "Gwas", full_data = FALSE, limit = 5)
#' }
#'
#' # List the 6th - 10th Disease nodes, with full properties
#' \dontrun{
#' meta_nodes_list_node(meta_node = "Disease", full_data = TRUE, limit = 5, offset = 0)
#' }
#' @export
meta_nodes_list_node <- function(meta_node, full_data = TRUE, limit = 10, offset = 0,
                                 mode = c("table", "raw")) {
  mode <- match.arg(mode)
  response <- query_epigraphdb(
    route = glue::glue("/meta/nodes/{meta_node}/list"),
    params = list(
      full_data = full_data, limit = limit, offset = offset
    ),
    mode = mode
  )
  response
}

#' List relationships under a meta relationship
#'
#' [`GET /meta/rels/{meta_rel}/list`](https://docs.epigraphdb.org/api/api-endpoints/#get-metarelsmeta_rellist)
#'
#' @inheritParams mr
#' @param meta_rel
#' Name of a meta relationship (e.g. MR). Use `meta_rels_list` to get the full list of meta relationships.
#' @param limit
#' Max number of items to retrieve.
#' @param offset
#' Number of items to skip. Use `limit` and `offset` in combination to do pagination.
#'
#' @return Data from `GET /meta/rels/{meta_rel}/list`
#'
#' @examples
#' # List the first 5 MR relationships
#' \dontrun{
#' meta_rels_list_rel(meta_rel = "MR_EVE_MR", limit = 5)
#' }
#' @export
meta_rels_list_rel <- function(meta_rel, limit = 10, offset = 0,
                               mode = c("table", "raw")) {
  mode <- match.arg(mode)
  response <- query_epigraphdb(
    route = glue::glue("/meta/rels/{meta_rel}/list"),
    params = list(
      limit = limit, offset = offset
    ),
    mode = mode
  )
  response
}

#' Search a node by its id field, or its name field
#'
#' [`GET /meta/nodes/{meta_node}/search`](https://docs.epigraphdb.org/api/api-endpoints/#get-metanodesmeta_nodesearch)
#'
#' @inheritParams mr
#' @param meta_node
#' Name of a meta node (e.g. Gwas). Use `meta_nodes_list` to get the full list of meta nodes.
#' @param id
#' The id field of a node (e.g. "ieu-a-2" for a Gwas).
#' Use EpiGraphDB web UI to get a sense of what those ids are for entities.
#' @param name
#' The name field of a node (e.g. "body mass index" for a Gwas).
#' Use EpiGraphDB web UI to get a sense of what those names are for entities.
#' @param full_data
#' When False, only return the id and name fields (their specific names differ in specific nodes) for a node.
#' This is useful if you want your queries to return results faster with smaller amount of data requested.
#' @param limit
#' Max number of items to retrieve.
#'
#' @return Data from `GET /meta/nodes/{meta_node}/search`
#'
#' @examples
#' # Search Gwas nodes
#' \dontrun{
#' meta_nodes_search_node(meta_node = "Gwas", name = "body mass index")
#' }
#' @export
meta_nodes_search_node <- function(meta_node,
                                   id = NULL, name = NULL,
                                   limit = 10, full_data = TRUE,
                                   mode = c("table", "raw")) {
  mode <- match.arg(mode)
  response <- query_epigraphdb(
    route = glue::glue("/meta/nodes/{meta_node}/search"),
    params = list(
      full_data = full_data,
      id = id, name = name,
      limit = limit
    ),
    mode = mode
  )
  response
}
