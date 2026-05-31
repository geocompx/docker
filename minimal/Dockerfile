ARG ROCKER_GEOSPATIAL_IMAGE=rocker/geospatial:latest
FROM ${ROCKER_GEOSPATIAL_IMAGE}

ARG QUARTO_VERSION=1.9.37

LABEL devcontainer.metadata='[{"customizations":{"vscode":{"extensions":["quarto.quarto","REditorSupport.r","ms-python.python","ms-toolsai.jupyter"]}}}]'

# Install arf — Alternative R Frontend (https://github.com/eitsupi/arf)
RUN export ARF_CONSOLE_INSTALL_DIR=/usr/local ARF_CONSOLE_NO_MODIFY_PATH=1 \
    && wget -qO /tmp/arf-installer.sh https://github.com/eitsupi/arf/releases/download/v0.3.4/arf-console-installer.sh \
    && sh /tmp/arf-installer.sh \
    && rm /tmp/arf-installer.sh

# Update quarto to latest stable version:
RUN /rocker_scripts/install_quarto.sh ${QUARTO_VERSION}

# Set RStudio preferences
# No inline code:
RUN echo '{' >> /etc/rstudio/rstudio-prefs.json
RUN echo '    "rmd_chunk_output_inline": false' >> /etc/rstudio/rstudio-prefs.json
RUN echo '}' >> /etc/rstudio/rstudio-prefs.json

# System-wide shell alias to make 'R' run 'arf' in interactive shells
RUN echo "alias R=arf" >> /etc/bash.bashrc

# Clean up apt caches
RUN rm -rf /var/lib/apt/lists/*
