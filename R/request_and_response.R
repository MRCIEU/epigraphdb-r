#' Wrapper of httr::GET that handles status errors and custom headers
#'
#' @param endpoint An EpiGraphDB API endpoint, e.g. "/mr"
#' @param params GET request params
#'
#' @keywords internal
api_get_request <- function(endpoint, params) {
  api_url <- getOption("epigraphdb.api.url") # nolint
  response <- httr::GET(glue::glue("{api_url}{endpoint}"),
    query = params,
    httr::add_headers(.headers = c("client-type" = "R"))
  )
  stop_for_status(response, call = sys.call(-1))
  response
}

#' Flatten the "results" field from an API response to a tibble df
#'
#' The general tibble flattener for EpiGraphDB endpoints
#'
#' @param response An httr response
#'
#' @param field Default to the "results" field
#'
#' @return A tibble df
#'
#' @keywords internal
flatten_response <- function(response, field = "results") {
  response %>%
    httr::content(as = "text", encoding = "utf-8") %>%
    jsonlite::fromJSON(flatten = TRUE) %>%
    purrr::pluck(field) %>%
    tibble::as_tibble()
}

#' Catch error for an HTTP response
#'
#' Modifies from httr::stop_for_status
#'
#' @title
#' @param response An httr response
#'
#' @keywords internal
stop_for_status <- function(response, call = sys.call(-1)) {
  if (httr::status_code(response) < 300) {
    return(invisible(response))
  }

  stop(http_condition(response, call = call))
}

#' Modified httr::http_condition
#'
#' @param response An httr response
#' @param call The function call
#'
#' @keywords internal
http_condition <- function(response, call = sys.call(-1)) {
  status <- httr::status_code(response)
  reason <- httr::http_status(status)$reason
  detail <- paste(
    utils::capture.output(httr::content(response)),
    collapse = "\n"
  )

  message <- sprintf("%s (HTTP %d).\nDetail:\n%s", reason, status, detail)

  status_type <- (status %/% 100) * 100

  structure(
    list(message = message, call = call)
  )
}
