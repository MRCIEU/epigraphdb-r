.PHONY: lint docs build test tests fmt init

#################################################################################
# GLOBALS                                                                       #
#################################################################################

PROJECT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
PROJECT_NAME = epigraphdb-r

#################################################################################
# Rules
#################################################################################

## Init (install a local copy and its development dependencies)
init:
	Rscript -e "devtools::install(dependencies = TRUE)"

## Check package infrastructure and perform unit tests
tests:
	Rscript -e "devtools::check()"

test: tests

check: tests

## Lint codebase
lint:
	Rscript -e "lintr::lint_package()"

## Format codebase
fmt:
	Rscript -e "styler::style_pkg(filetype=c('R', 'Rmd'))"

## Build package
build:
	Rscript -e "devtools::build()"

## Build package and install locally
install:
	Rscript -e "devtools::install()"

## Uninstall
uninstall:
	Rscript -e "devtools::uninstall()"

## Build documentation
docs:
	Rscript -e "devtools::document()"
	Rscript -e "pkgdown::build_site(preview = TRUE)"

## Check for CRAN submission (via rhub)
check-cran:
	# NOTE: the env_var tries to deal with utf8 issues
	# https://github.com/r-hub/rhub/issues/374
	Rscript -e "rhub::check_for_cran(env_vars=c(R_COMPILE_AND_INSTALL_PACKAGES = 'always'))"

## Check for MS windows compatibility (via devtools::check_win_devel)
check-windows:
	Rscript -e "devtools::check_win_devel()"

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
