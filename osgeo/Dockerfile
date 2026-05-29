FROM rocker/geospatial:dev-osgeo
RUN R -e "if (!requireNamespace('pak', quietly = TRUE)) install.packages('pak', repos = 'https://cloud.r-project.org/'); pak::pak('geocompx/geocompkg', upgrade = TRUE)"
# Install arf — Alternative R Frontend (https://github.com/eitsupi/arf)
RUN ARF_CONSOLE_INSTALL_DIR=/usr/local ARF_CONSOLE_NO_MODIFY_PATH=1 \
    curl --proto '=https' --tlsv1.2 -LsSf https://github.com/eitsupi/arf/releases/download/v0.3.4/arf-console-installer.sh | sh

# Set RStudio preferences
# No inline code:
RUN echo '{' >> /etc/rstudio/rstudio-prefs.json
RUN echo '    "rmd_chunk_output_inline": false' >> /etc/rstudio/rstudio-prefs.json
RUN echo '}' >> /etc/rstudio/rstudio-prefs.json
