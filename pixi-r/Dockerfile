FROM ghcr.io/prefix-dev/pixi:bullseye

# Copy the pixi.toml file
# COPY pixi.toml .

# Install dependencies using pixi
RUN pixi global install r r-tidyverse r-sf r-terra r-stars r-tmap r-mlr3 r-remotes r-knitr r-bookdown r-tidygraph r-leaflet r-plotly r-curl r-languageserver
# RUN pixi run R -e 'remotes::install_github("geocompx/geocompkg", dependencies = TRUE, upgrade = FALSE)'