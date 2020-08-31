#' Send data request to an EpiGraphDB API endpoint
#'
#' This is a general purpose function to send data request
#' which can be used when there has not been an R equivalent package function
#' to an API endpoint.
#' Underneath this is a wrapper around `httr` functions with better handling of
#' returned status.
#'
#' @param route An EpiGraphDB API endpoint route, e.g. `"/mr"` or `"/confounder"`.
#' Consult the [EpiGraphDB API documentation](https://api.epigraphdb.org).
#' @param params A list of parameters associated with the query endpoint.
#' @param mode `c("raw", "table")`, if `"table"` then the query handler will try
#' to convert the returned data to a tibble dataframe.
#' NOTE: The default mode is "raw" which will NOT convert the returned response to
#' a dataframe.
#' This is different to functions that query topic endpoints which
#' default to return a dataframe.
#' Explicitly specify `mode = "table"` when needed.
#' @param method Type of HTTP (GET, POST, PUT, etc.) method.
#'
#' NOTE: When sending a POST request where a specific parameter is specified as a list on the API,
#'       and if the equivalent in R is a vector of length 1, you should wrap this parameter
#'       in `I()`, e.g. I(c("APOE")) to avoid auto unboxing.
#'       For details, please refer to [`httr::POST`](https://httr.r-lib.org/reference/POST.html)
#'
#' @param retry_times Number of times the function will retry the request to the API.
#' @param retry_pause_min Minimum number of seconds to wait for the next retry.
#'
#' @return Data from an EpiGraphDB API endpoint.
#'
#' @examples
#' # GET /mr
#' # equivalent to `mr(exposure_trait = "Body mass index", outcome_trait = "Coronary heart disease")`
#' query_epigraphdb(
#'   route = "/mr",
#'   params = list(
#'     exposure_trait = "Body mass index",
#'     outcome_trait = "Coronary heart disease"
#'   ),
#'   mode = "table"
#' )
#'
#' # GET /meta/nodes/Gwas/list
#' query_epigraphdb(
#'   route = "/meta/nodes/Gwas/list",
#'   params = list(
#'     limit = 5,
#'     offset = 0
#'   )
#' ) %>% str(1)
#'
#' # POST /protein/ppi
#' query_epigraphdb(
#'   route = "/protein/ppi",
#'   params = list(
#'     uniprot_id_list = c("P30793", "Q9NZM1", "O95236")
#'   ),
#'   method = "POST"
#' )
#'
#' # error handling
#' tryCatch(
#'   query_epigraphdb(
#'     route = "/mr",
#'     params = list(
#'       exposure_trait = NULL,
#'       outcome_trait = NULL
#'     ),
#'     retry_times = 0
#'   ),
#'   error = function(e) {
#'     message(e)
#'   }
#' )
#' @export
query_epigraphdb <- function(route, params = NULL,
                             mode = c("raw", "table"),
                             method = c("GET", "POST"),
                             retry_times = 5,
                             retry_pause_min = 4) {
  mode <- match.arg(mode)
  method <- match.arg(method)
  # NOTE: Add POST at a later date
  if (method == "GET") {
    method_func <- api_get_request
  } else if (method == "POST") {
    method_func <- api_post_request
  }
  res <- api_request(
    route = route, params = params, mode = mode, method = method_func,
    retry_times = retry_times, retry_pause_min = retry_pause_min
  )
  res
}

#' Wrapper of httr::GET that handles status errors and custom headers
#'
#' @param route An EpiGraphDB API endpoint route, e.g. "/mr"
#' @param params GET request params
#' @param call The function call to identify the original function
#' when things go wrong
#'
#' @keywords internal
api_get_request <- function(route, params,
                            retry_times, retry_pause_min,
                            call = sys.call(-1)) {
  api_url <- getOption("epigraphdb.api.url") # nolint
  url <- glue::glue("{api_url}{route}")
  is_ci <- getOption("epigraphdb.ci") %>%
    as.character() %>%
    tolower()
  config <- httr::add_headers(.headers = c("client-type" = "R", "ci" = is_ci))
  response <- httr::RETRY(
    "GET",
    url = url, query = params, config = config,
    times = retry_times, pause_min = retry_pause_min
  )
  stop_for_status(response, call = sys.call(-1))
  response
}

#' Wrapper of httr::POST that handles status errors and custom headers
#'
#' @param route An EpiGraphDB API endpoint route, e.g. "/mr"
#' @param params POST request payload
#' @param call The function call to identify the original function
#' when things go wrong
#'
#' @keywords internal
api_post_request <- function(route, params,
                             retry_times, retry_pause_min,
                             call = sys.call(-1)) {
  api_url <- getOption("epigraphdb.api.url") # nolint
  url <- glue::glue("{api_url}{route}")
  is_ci <- getOption("epigraphdb.ci") %>%
    as.character() %>%
    tolower()
  config <- httr::add_headers(.headers = c("client-type" = "R", "ci" = is_ci))
  body <- jsonlite::toJSON(params, auto_unbox = TRUE)
  response <- httr::RETRY(
    "POST",
    url = url, body = body, config = config,
    times = retry_times, pause_min = retry_pause_min
  )
  stop_for_status(response, call = sys.call(-1))
  response
}

#' The very general wrapper from EpiGraphDB endpoint request
#'
#' @param route An EpiGraphDB API endpoint route, e.g. "/mr"
#' @param params A list of parameters to send
#' @param mode Either `"table"` (returns tibble) or
#' `"raw"` (returns raw response parsed from json to R list).
#' @param method A specific request handler, e.g. `epi_get_request`
#' @param call The function call to identify the original function
#' when things go wrong
#'
#' @keywords internal
api_request <- function(route, params,
                        mode = c("table", "raw"),
                        method = api_get_request,
                        retry_times, retry_pause_min,
                        call = sys.call(-1)) {
  mode <- match.arg(mode)
  response <- do.call(method, args = list(
    route = route, params = params,
    retry_times = retry_times, retry_pause_min = retry_pause_min,
    call = call
  ))
  if (mode == "table") {
    return(flatten_response(response))
  }
  response %>% httr::content(as = "parsed", encoding = "utf-8")
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
