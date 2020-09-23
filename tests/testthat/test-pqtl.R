context("pqtl")

test_that("pqtl protein endpoint", {
  url <- getOption("epigraphdb.api.url")
  query <- "ADAM19"
  rtype <- "mrres"
  pvalue <- 0.05
  searchflag <- "proteins"
  r <- httr::RETRY("GET", glue::glue("{url}/pqtl/"),
    query = list(
      query = query,
      rtype = rtype,
      pvalue = pvalue,
      searchflag = searchflag
    ),
    config = httr::add_headers(.headers = c("client-type" = "R", "ci" = "true"))
  )
  expect_equal(httr::status_code(r), 200)
  expect_true(length(httr::content(r)) > 0)
})

test_that("pqtl trait endpoint", {
  url <- getOption("epigraphdb.api.url")
  query <- "Inflammatory bowel disease"
  rtype <- "mrres"
  pvalue <- 0.05
  searchflag <- "traits"
  r <- httr::RETRY("GET", glue::glue("{url}/pqtl/"),
    query = list(
      query = query,
      rtype = rtype,
      pvalue = pvalue,
      searchflag = searchflag
    ),
    config = httr::add_headers(.headers = c("client-type" = "R", "ci" = "true"))
  )
  expect_equal(httr::status_code(r), 200)
})

test_that("pqtl_pleio endpoint", {
  url <- getOption("epigraphdb.api.url")
  rsid <- "rs1260326"
  prflag <- "proteins"
  r <- httr::RETRY("GET", glue::glue("{url}/pqtl/pleio/"),
    query = list(
      rsid = rsid,
      prflag = prflag
    ),
    config = httr::add_headers(.headers = c("client-type" = "R", "ci" = "true"))
  )
  expect_equal(httr::status_code(r), 200)
})

test_that("pqtl_list endpoint", {
  url <- getOption("epigraphdb.api.url")
  flag <- "exposures"
  r <- httr::RETRY("GET", glue::glue("{url}/pqtl/list/"),
    query = list(
      flag = flag
    ),
    config = httr::add_headers(.headers = c("client-type" = "R", "ci" = "true"))
  )
  expect_equal(httr::status_code(r), 200)
})

test_that("pqtl correct input", {
  query <- "Inflammatory bowel disease"
  rtype <- "mrres"
  pvalue <- 0.05
  searchflag <- "traits"
  r <- pqtl(
    query = query,
    rtype = rtype,
    pvalue = pvalue,
    searchflag = searchflag,
    mode = "table"
  )
  expect_is(r, "tbl_df")
  expect_true(dim(r)[1] > 0)
})

test_that("pqtl incorrect input", {
  query <- "Inflammatory bowel disease"
  rtype <- "mrress"
  pvalue <- 0.05
  searchflag <- "traits"
  expect_error(
    r <- pqtl(
      query = query,
      rtype = rtype,
      pvalue = pvalue,
      searchflag = searchflag
    )
  )
})

test_that("pqtl not found input", {
  query <- "ADAM199999"
  rtype <- "mrres"
  pvalue <- 0.05
  searchflag <- "proteins"
  r <- pqtl(
    query = query,
    rtype = rtype,
    pvalue = pvalue,
    searchflag = searchflag
  )
  expect_equal(dim(r), c(0, 0))
})

test_that("pqtl_pleio correct input for a list of proteins", {
  rsid <- "rs1260326"
  prflag <- "proteins"
  r <- pqtl_pleio(
    rsid = rsid,
    prflag = prflag
  )
  expect_true(dim(r)[1] > 0)
})

test_that("pqtl_pleio correct input for a count", {
  rsid <- "rs1260326"
  prflag <- "count"
  r <- pqtl_pleio(
    rsid = rsid,
    prflag = prflag
  )
  expect_equal(r, 3)
})

test_that("pqtl_pleio incorrect input", {
  rsid <- "rs1260326"
  prflag <- "countt"
  expect_error(
    r <- pqtl_pleio(
      rsid = rsid,
      prflag = prflag
    )
  )
})

test_that("pqtl_pleio not found input", {
  rsid <- "rs1260326gggg"
  prflag <- "proteins"
  r <- pqtl_pleio(
    rsid = rsid,
    prflag = prflag
  )
  expect_equal(dim(r), c(0, 0))
})

test_that("pqtl_list raw", {
  flag <- "exposures"
  r <- pqtl_list(
    flag = flag,
    mode = "raw"
  )
  expect_true(length(r) > 1)
})

test_that("pqtl_list correct exposures input", {
  flag <- "exposures"
  r <- pqtl_list(
    flag = flag
  )
  expect_is(r, "tbl_df")
  expect_true(dim(r)[1] > 0)
})

test_that("pqtl_list correct outcomes input", {
  flag <- "outcomes"
  r <- pqtl_list(
    flag = flag
  )
  expect_is(r, "tbl_df")
  expect_true(dim(r)[1] > 0)
})

test_that("pqtl_list incorrect input", {
  flag <- "foobar"
  expect_error(
    r <- pqtl_list(
      flag = flag
    )
  )
})
