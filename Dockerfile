FROM rocker/tidyverse:4.1.2
MAINTAINER Yi Liu <yi6240.liu@bristol.ac.uk>

RUN apt --allow-releaseinfo-change update && \
  apt install -y make r-cran-igraph
WORKDIR /data
COPY ./DESCRIPTION ./
RUN Rscript -e "devtools::install(dependencies = TRUE)"
CMD bash
