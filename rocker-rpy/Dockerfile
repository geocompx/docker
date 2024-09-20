FROM rocker/geospatial:latest
RUN /rocker_scripts/install_python.sh
RUN R -e "options(repos = c(geocompr = 'https://geocompr.r-universe.dev', CRAN = 'https://cloud.r-project.org')); install.packages('geocompkg')"

# Copy and install Python packages from the remote requirements file
RUN pip install -r https://github.com/geocompx/geocompy/raw/refs/heads/main/requirements.txt

# Set RStudio preferences
# No inline code:
RUN echo '{' >> /etc/rstudio/rstudio-prefs.json
RUN echo '    "rmd_chunk_output_inline": false' >> /etc/rstudio/rstudio-prefs.json
RUN echo '}' >> /etc/rstudio/rstudio-prefs.json
