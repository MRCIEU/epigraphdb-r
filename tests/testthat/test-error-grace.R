context("request_and_response")

test_that("Give informative error message when server error", {
  skip_on_cran()
  inform_status <- function(url) {
    params <- list(param_a = "a", param_b = "b")
    response <- httr::RETRY(
      "GET",
      url = url, query = params,
      times = 2, pause_min = 0.5
    )
    stop_for_status(response, context = list(url = url, params = params))
    response
  }
  url <- "http://httpbin.org/status/500"
  expect_error(
    inform_status(url),
    "500"
  )
})
