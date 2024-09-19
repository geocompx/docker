FROM rocker/geospatial:latest
RUN /rocker_scripts/install_python.sh
RUN /rocker_scripts/install_julia.sh
RUN R -e "options(repos = c(geocompr = 'https://geocompr.r-universe.dev', CRAN = 'https://cloud.r-project.org')); install.packages('geocompkg')"

# Set RStudio preferences
# No inline code:
RUN echo '{' >> /etc/rstudio/rstudio-prefs.json
RUN echo '    "rmd_chunk_output_inline": false' >> /etc/rstudio/rstudio-prefs.json
RUN echo '}' >> /etc/rstudio/rstudio-prefs.json
