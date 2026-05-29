FROM rocker/geospatial:dev-osgeo
RUN R -e "if (!requireNamespace('pak', quietly = TRUE)) install.packages('pak', repos = 'https://cloud.r-project.org/'); pak::pak('geocompx/geocompkg', upgrade = TRUE)"
# Install arf — Alternative R Frontend (https://github.com/eitsupi/arf)
# Pin to specific version for reproducible builds
RUN curl --proto '=https' --tlsv1.2 -LsSf https://github.com/eitsupi/arf/releases/latest/download/arf-console-installer.sh | sh && cp /root/.cargo/bin/arf /usr/local/bin/arf

# Set RStudio preferences
# No inline code:
RUN echo '{' >> /etc/rstudio/rstudio-prefs.json
RUN echo '    "rmd_chunk_output_inline": false' >> /etc/rstudio/rstudio-prefs.json
RUN echo '}' >> /etc/rstudio/rstudio-prefs.json

# System-wide shell alias to make 'R' run 'arf' in interactive shells
RUN echo "alias R=arf" >> /etc/bash.bashrc
