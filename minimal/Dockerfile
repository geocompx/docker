ARG ROCKER_GEOSPATIAL_IMAGE=rocker/geospatial:latest
FROM ${ROCKER_GEOSPATIAL_IMAGE}

ARG QUARTO_VERSION=1.9.37

# Ship editor defaults with the image so downstream Codespaces/devcontainers
# inherit Quarto support even when they only reference the published image.
LABEL devcontainer.metadata='[{"customizations":{"vscode":{"extensions":["quarto.quarto","REditorSupport.r","ms-python.python","ms-toolsai.jupyter"]}}}]'

RUN R -e "install.packages('remotes', repos = 'https://cloud.r-project.org/'); remotes::install_github('geocompx/geocompkg', upgrade = TRUE)"
# Update quarto to latest stable version:
RUN /rocker_scripts/install_quarto.sh ${QUARTO_VERSION}
# Set RStudio preferences
# No inline code:
RUN echo '{' >> /etc/rstudio/rstudio-prefs.json
RUN echo '    "rmd_chunk_output_inline": false' >> /etc/rstudio/rstudio-prefs.json
RUN echo '}' >> /etc/rstudio/rstudio-prefs.json
