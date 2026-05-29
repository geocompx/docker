ARG ROCKER_GEOSPATIAL_IMAGE=rocker/geospatial:latest
FROM ${ROCKER_GEOSPATIAL_IMAGE}

ARG QUARTO_VERSION=1.9.37

# Ship editor defaults with the image so downstream Codespaces/devcontainers
# inherit Quarto support even when they only reference the published image.
LABEL devcontainer.metadata='[{"customizations":{"vscode":{"extensions":["quarto.quarto","REditorSupport.r","ms-python.python","ms-toolsai.jupyter"]}}}]'

RUN R -e "if (!requireNamespace('pak', quietly = TRUE)) install.packages('pak', repos = 'https://cloud.r-project.org/'); pak::pak('geocompx/geocompkg', upgrade = TRUE)"
# Install arf — Alternative R Frontend (https://github.com/eitsupi/arf)
# Pin to specific version for reproducible builds
RUN curl --proto '=https' --tlsv1.2 -LsSf https://github.com/eitsupi/arf/releases/latest/download/arf-console-installer.sh | sh && cp /root/.cargo/bin/arf /usr/local/bin/arf
# Update quarto to latest stable version:
RUN /rocker_scripts/install_quarto.sh ${QUARTO_VERSION}
# Set RStudio preferences
# No inline code:
RUN echo '{' >> /etc/rstudio/rstudio-prefs.json
RUN echo '    "rmd_chunk_output_inline": false' >> /etc/rstudio/rstudio-prefs.json
RUN echo '}' >> /etc/rstudio/rstudio-prefs.json

# System-wide shell alias to make 'R' run 'arf' in interactive shells
RUN echo "alias R=arf" >> /etc/bash.bashrc
