FROM rocker/geospatial:latest
RUN R -e "remotes::install_github('geocompx/geocompkg', upgrade = TRUE)"
# Update quarto to latest stable version:
RUN /rocker_scripts/install_quarto.sh 1.7.24
# Set RStudio preferences
# No inline code:
RUN echo '{' >> /etc/rstudio/rstudio-prefs.json
RUN echo '    "rmd_chunk_output_inline": false' >> /etc/rstudio/rstudio-prefs.json
RUN echo '}' >> /etc/rstudio/rstudio-prefs.json
