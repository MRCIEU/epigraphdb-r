.PHONY: lint docs build test tests fmt init

#################################################################################
# Rules
#################################################################################

## ==== codebase ====

## Lint codebase
lint:
	Rscript -e "lintr::lint_package()"

## Format codebase
fmt:
	Rscript -e "styler::style_pkg(filetype=c('R', 'Rmd'))"

## Update rd docs
roxygen:
	CI=true Rscript -e "devtools::document()"

## devtools::check (superset of unit tests)
check:
	CI=true Rscript -e "devtools::check()"

## testthat
test:
	CI=true Rscript -e "devtools::test()"

tests: test

## Build pkgdown documentation
docs:
	CI=true Rscript -e "pkgdown::build_site()"

## ==== CRAN submission ====

## Build package
build:
	CI=true Rscript -e "devtools::build(path = '/build/', vignettes = TRUE, manual = TRUE)"

## Check for CRAN submission
## (note: assuming path to package is /build/epigraphdb_0.2.3.tar.gz)
r-cmd-check:
	CI=true R CMD check --as-cran /build/epigraphdb_0.2.3.tar.gz

## Check for CRAN submission (via rhub's remote specs)
## (note: you should have manually done rhub::validate_email,
## as https://r-hub.github.io/rhub/articles/rhub.html)
rhub-check-cran:
	# NOTE: the env_var tries to deal with utf8 issues
	# https://github.com/r-hub/rhub/issues/374
	# Rscript -e "rhub::check_for_cran(env_vars=c(R_COMPILE_AND_INSTALL_PACKAGES = 'always'))"
	Rscript -e "devtools::check_rhub(interactive = FALSE, env_vars=c(R_COMPILE_AND_INSTALL_PACKAGES = 'always'))"

## Check for MS windows compatibility (via devtools::check_win_devel)
rhub-check-windows:
	Rscript -e "devtools::check_win_devel()"
	Rscript -e "devtools::check_win_release()"

## ==== less frequently used utils ====

## Init (install a local copy and its development dependencies)
init:
	Rscript -e "devtools::install(dependencies = TRUE)"

## Build package and install locally
install:
	Rscript -e "devtools::install()"

## Uninstall
uninstall:
	Rscript -e "devtools::uninstall()"

## Check for CRAN submission (via rhub's local docker container); requirement: sysreqs, and github version of rhub
check-cran-local:
	# NOTE: the env_var tries to deal with utf8 issues
	# https://github.com/r-hub/rhub/issues/374
	Rscript -e "rhub::local_check_linux(env_vars=c(R_COMPILE_AND_INSTALL_PACKAGES = 'always'))"

#################################################################################
# Self Documenting Commands                                                     #
#################################################################################

.DEFAULT_GOAL := help

.PHONY: help
help:
	@echo "$$(tput bold)Available rules:$$(tput sgr0)"
	@echo
	@sed -n -e "/^## / { \
		h; \
		s/.*//; \
		:doc" \
		-e "H; \
		n; \
		s/^## //; \
		t doc" \
		-e "s/:.*//; \
		G; \
		s/\\n## /---/; \
		s/\\n/ /g; \
		p; \
	}" ${MAKEFILE_LIST} \
	| awk -F '---' \
		-v ncol=$$(tput cols) \
		-v indent=19 \
		-v col_on="$$(tput setaf 6)" \
		-v col_off="$$(tput sgr0)" \
	'{ \
		printf "%s%*s%s ", col_on, -indent, $$1, col_off; \
		n = split($$2, words, " "); \
		line_length = ncol - indent; \
		for (i = 1; i <= n; i++) { \
			line_length -= length(words[i]) + 1; \
			if (line_length <= 0) { \
				line_length = ncol - indent - length(words[i]) - 1; \
				printf "\n%*s ", -indent, " "; \
			} \
			printf "%s ", words[i]; \
		} \
		printf "\n"; \
	}'
