FROM rocker/geospatial:dev-osgeo
RUN R -e "remotes::install_github('geocompx/geocompkg', upgrade = TRUE)"

# Set RStudio preferences
# No inline code:
RUN echo '{' >> /etc/rstudio/rstudio-prefs.json
RUN echo '    "rmd_chunk_output_inline": false' >> /etc/rstudio/rstudio-prefs.json
RUN echo '}' >> /etc/rstudio/rstudio-prefs.json
