context("meta")

test_that("GET /meta/nodes/list", {
  skip_on_cran()
  url <- getOption("epigraphdb.api.url")
  route <- "/meta/nodes/list"
  r <- httr::RETRY("GET",
    url = glue::glue("{url}{route}"),
    config = httr::add_headers(.headers = c("client-type" = "R", "ci" = "true"))
  )
  expect_equal(httr::status_code(r), 200)
  expect_true(length(httr::content(r)) > 0)
})

test_that("GET /meta/rels/list", {
  skip_on_cran()
  url <- getOption("epigraphdb.api.url")
  route <- "/meta/rels/list"
  r <- httr::RETRY("GET",
    url = glue::glue("{url}{route}"),
    config = httr::add_headers(.headers = c("client-type" = "R", "ci" = "true"))
  )
  expect_equal(httr::status_code(r), 200)
  expect_true(length(httr::content(r)) > 0)
})

test_that("meta_nodes_list", {
  skip_on_cran()
  expect_error(
    meta_nodes_list(),
    NA
  )
})

test_that("meta_rels_list", {
  skip_on_cran()
  expect_error(
    meta_rels_list(),
    NA
  )
})

test_that("meta_nodes_list_node", {
  skip_on_cran()
  meta_node <- "Gwas"
  expect_error(
    meta_nodes_list_node(
      meta_node = meta_node
    ),
    NA
  )
})

test_that("meta_rels_list_rel", {
  skip_on_cran()
  meta_rel <- "MR_EVE_MR"
  expect_error(
    meta_rels_list_rel(
      meta_rel = meta_rel
    ),
    NA
  )
})

test_that("meta_nodes_search_node, by id", {
  skip_on_cran()
  meta_node <- "Gwas"
  id <- "ieu-a-2"
  expect_error(
    meta_nodes_search_node(
      meta_node = meta_node,
      id = id
    ),
    NA
  )
})

test_that("meta_nodes_search_node, by name", {
  skip_on_cran()
  meta_node <- "Gwas"
  name <- "Body mass index"
  expect_error(
    meta_nodes_search_node(
      meta_node = meta_node,
      name = name
    ),
    NA
  )
})
