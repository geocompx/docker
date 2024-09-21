FROM ghcr.io/prefix-dev/pixi:bullseye

# Copy the pixi.toml file
# COPY pixi.toml .

# Install dependencies using pixi
RUN pixi global install quarto r r-tidyverse r-sf r-terra r-stars r-tmap r-mlr3 r-remotes r-knitr r-bookdown r-tidygraph r-leaflet r-plotly r-curl r-languageserver r-data.table

# ln all /root/.pixi/envs/r/bin and /root/.pixi/bin to /usr/local/bin:
RUN ln -sf /root/.pixi/envs/r/bin/* /usr/local/bin
RUN ln -sf /root/.pixi/bin/* /usr/local/bin
    
RUN R -e 'remotes::install_github("geocompx/geocompkg", dependencies = TRUE, upgrade = FALSE)'
# Set the default repos to cloud.r-project.org:
RUN echo 'options(repos = c(CRAN = "https://cloud.r-project.org/"))' >> /root/.Rprofile