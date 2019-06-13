.onAttach <- function(libname, pkgname) {
  packageStartupMessage(glue::glue("
    EpiGraphDB v0.2
    Please cite: PLACEHOLDER.

    Web API: http://api.epigraphdb.org

    To turn off this message, use
    suppressPackageStartupMessages({{library(\"epigraphdb\")}})
  "))
}

.onLoad <- function(libname, pkgname) {
  op <- options()
  op.epigraphdb <- list(
    # epigraphdb.api.url = "http://app-dc1-epigdb-p0.epi.bris.ac.uk:8035"
    epigraphdb.api.url = "http://jojo.epi.bris.ac.uk:8117"
  )
  toset <- !(names(op.epigraphdb) %in% names(op))
  if (any(toset)) options(op.epigraphdb[toset])

  invisible()
}
