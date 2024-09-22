FROM rocker/geospatial:latest
RUN R -e "options(repos = c(geocompr = 'https://geocompr.r-universe.dev', CRAN = 'https://cloud.r-project.org')); install.packages('geocompkg')"

# Update quarto to latest stable version:
RUN /rocker_scripts/install_quarto.sh 1.5.57

# Set RStudio preferences
# No inline code:
RUN echo '{' >> /etc/rstudio/rstudio-prefs.json
RUN echo '    "rmd_chunk_output_inline": false' >> /etc/rstudio/rstudio-prefs.json
RUN echo '}' >> /etc/rstudio/rstudio-prefs.json
