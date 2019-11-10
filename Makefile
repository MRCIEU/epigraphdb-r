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
	Rscript -e "devtools::test()"

test: tests

## Lint codebase
lint:
	Rscript -e "lintr::lint_package()"

## Format codebase
fmt:
	Rscript -e "usethis::use_tidy_style()"

## Build package and install locally
build:
	Rscript -e "devtools::install()"

## Build package and install locally
install: build

## Uninstall
uninstall:
	Rscript -e "devtools::uninstall()"

## Build documentation
docs:
	Rscript -e "devtools::document()"
	Rscript -e "pkgdown::build_site(preview = TRUE)"

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
