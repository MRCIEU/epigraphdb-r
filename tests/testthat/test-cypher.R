context("cypher")

test_that("POST /cypher", {
  skip_on_cran()
  url <- getOption("epigraphdb.api.url")
  route <- "/cypher"
  query <- "MATCH (n:Gwas) RETURN n LIMIT 2"
  body <- jsonlite::toJSON(list(query = query), auto_unbox = TRUE)
  r <- httr::RETRY(
    "POST",
    glue::glue("{url}{route}"),
    body = body,
    encode = "json",
    config = httr::add_headers(.headers = c("client-type" = "R", "ci" = "true"))
  )
  expect_equal(httr::status_code(r), 200)
  expect_true(length(httr::content(r)) > 0)
})

test_that("cypher", {
  skip_on_cran()
  query <- "MATCH (n:Gwas) RETURN n LIMIT 2"
  expect_error(
    cypher(query = query),
    NA
  )
})
