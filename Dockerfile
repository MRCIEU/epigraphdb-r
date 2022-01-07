FROM rocker/verse:4.1.2
MAINTAINER Yi Liu <yi6240.liu@bristol.ac.uk>

RUN apt --allow-releaseinfo-change update && \
  apt install -y \
  build-essential libglpk40 \
  texlive-fonts-recommended
WORKDIR /data
# install the dependencies of devtools which has not been fully installed
RUN Rscript -e "install.packages('devtools', dependencies = TRUE)"
COPY ./DESCRIPTION ./
RUN Rscript -e "devtools::install(dependencies = TRUE)"
CMD bash
