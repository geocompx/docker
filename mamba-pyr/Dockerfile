FROM mambaorg/micromamba:bookworm
USER root
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*
USER $MAMBA_USER
RUN curl -L -o environment.yml https://github.com/geocompx/geocompy/raw/main/environment.yml
RUN micromamba install -y -n base -f environment.yml
# Install R + packages sf, stars, terra, tmap, mlr3, remotes, knitr, bookdown, tidygraph, leaflet, plotly, curl, languageserver, data.table:
RUN micromamba install -y -n base -c conda-forge r r-tidyverse r-sf r-terra r-stars r-tmap r-mlr3 r-remotes r-knitr r-bookdown r-tidygraph r-leaflet r-plotly r-curl r-languageserver r-data.table r-reticulate
# TODO try with rspm, not working:
# RUN echo 'options(repos = c(CRAN = "https://packagemanager.rstudio.com/all/__linux__/focal/latest"))' >> /etc/R/Rprofile.site
# Install geocompkg:
# RUN R -e 'remotes::install_github("geocompx/geocompkg", dependencies = TRUE, upgrade = FALSE)'
RUN micromamba clean --all --yes
