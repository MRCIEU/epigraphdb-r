pwd <- getwd()

setwd("vignettes")

vignette_files <- c(
  "about.Rmd",
  "getting-started-with-epigraphdb-r.Rmd",
  "meta-functionalities.Rmd",
  "options.Rmd",
  "using-epigraphdb-api.Rmd",
  "using-epigraphdb-r-package.Rmd"
)

for (file in vignette_files) {
  cat(glue::glue("Building {file}\n"))
  knitr::knit(glue::glue("../vignettes_src/{file}"), glue::glue("{file}"))
}

setwd(pwd)
