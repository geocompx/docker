ARG ROCKER_GEOSPATIAL_IMAGE=rocker/geospatial:latest
FROM ${ROCKER_GEOSPATIAL_IMAGE}

# Drop packages that are not needed for R geospatial work
# (keep libgdal-dev/libgeos-dev/libproj-dev — needed by sf/terra)
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get purge -y postgis netcdf-bin \
    && apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install essential geocompkg Imports + VS Code R extension (vscode-R v3+)
# session/plot/LSP dependencies (languageserver, httpgd, jgd, rstudioapi,
# processx, ps, later, jsonlite, svglite) so interactive R sessions attach
# immediately without compiling or downloading packages on first chunk run.
RUN R -e "if (!requireNamespace('pak', quietly = TRUE)) install.packages('pak', repos = 'https://cloud.r-project.org/'); pak::pak(c('sf','terra','spData','units','dplyr','languageserver','httpgd','jgd','rstudioapi','processx','ps','later','jsonlite','svglite','methods'), upgrade = FALSE)"

# Install arf (modern Rust-based R console used by vscode-R persistent sessions)
RUN curl --proto '=https' --tlsv1.2 -LsSf https://github.com/eitsupi/arf/releases/latest/download/arf-console-installer.sh | env ARF_INSTALL_DIR=/usr/local/bin sh

# Strip binary shared libraries from RSPM packages to reduce final image size
# See https://github.com/rocker-org/rocker-versioned2/issues/340
RUN strip /usr/local/lib/R/site-library/*/libs/*.so

# Set RStudio preferences — no inline code
RUN echo '{' > /etc/rstudio/rstudio-prefs.json \
    && echo '    "rmd_chunk_output_inline": false' >> /etc/rstudio/rstudio-prefs.json \
    && echo '}' >> /etc/rstudio/rstudio-prefs.json

# Configure Rprofile.site for quiet sess connection and plot device fallback in VS Code / Codespaces
RUN echo 'if (interactive() && (Sys.getenv("TERM_PROGRAM") == "vscode" || Sys.getenv("CODESPACES") == "true")) {' >> /usr/local/lib/R/etc/Rprofile.site \
    && echo '  options(sess.quiet = TRUE)' >> /usr/local/lib/R/etc/Rprofile.site \
    && echo '  if (!requireNamespace("jgd", quietly = TRUE) && requireNamespace("httpgd", quietly = TRUE)) {' >> /usr/local/lib/R/etc/Rprofile.site \
    && echo '    options(device = httpgd::hgd)' >> /usr/local/lib/R/etc/Rprofile.site \
    && echo '  }' >> /usr/local/lib/R/etc/Rprofile.site \
    && echo '}' >> /usr/local/lib/R/etc/Rprofile.site

# Clean up apt caches
RUN rm -rf /var/lib/apt/lists/*
