# epigraphdb 0.2.4

* Remove some non-runtime dependencies from the Imports and Suggests lists.

# epigraphdb 0.2.3 (2022-01-14)

- Error handling logics have been overhauled.
  - Now it is easier to see the context when a request function fails
- Vignettes on case studies of using EpiGraphDB functionalities have been moved to [EpiGraphDB's platform documentation](https://docs.epigraphdb.org). This is to make the package building process faster and less error prone. Specifically, it involves these vignette articles:
  - [Case 1 pleiotropy](https://docs.epigraphdb.org/r-package/case-1-pleiotropy/)
  - [Case 2 alternative drug target](https://docs.epigraphdb.org/r-package/case-2-alt-drug-target/)
  - [Case 3 literature triangulation](https://docs.epigraphdb.org/r-package/case-3-literature-triangulation/)
- (For developers) Added docker for package development in a portable and consistent development environment.

# epigraphdb 0.2.2 (2021-03-21)

- Switch to github actions for building the package documentation site.
- Switch to EpiGraphDB v1.0.0 API.

# epigraphdb 0.2.1 (2020-08-06)

- use `httr::RETRY` to mitigate problems due to network errors.
- Shortened the startup message.
- Added functions `protein_in_pathway`, `mappings_gene_to_protein`
- Added RMarkdown vignettes to the equivalent Jupyter notebooks in the
  [EpiGraphDB GitHub repo](https://github.com/MRCIEU/epigraphdb).
- Added functions `meta_nodes_list`, `meta_rels_list`, `meta_nodes_list_node`, `meta_rels_list_rel`,
  `meta_nodes_search_node`, `cypher`

# epigraphdb 0.2 (2020-04-21)

- Migrated to EpiGraphDB v0.3.0 API.

# epigraphdb 0.1.0.9

Current ongoing development

- (2020-03) Move upstream API url to https://api.epigraphdb.org/v0.2.0
- (2019-11) Migrated to github and travis CI.
  Current documentation site is now `https://mrcieu.github.io/epigraphdb-r`.

# epigraphdb 0.1 (2019-07-04)

Initial release on github

# epigraphdb 0.0.0.9000 (2019-04-11)

Initial pre-development
