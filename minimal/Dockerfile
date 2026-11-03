FROM rocker/geospatial:latest

LABEL org.opencontainers.image.authors="Robin Lovelace <rob00x@gmail.com>, Jakub Nowosad <nowosad.jakub@gmail.com>" \
      org.opencontainers.image.source="https://github.com/geocompx/docker" \
      devcontainer.metadata='[{"customizations":{"vscode":{"extensions":["REditorSupport.r","Posit.air-vscode","quarto.quarto"],"settings":{"r.rterm.linux":"/usr/local/bin/R","r.rpath.linux":"/usr/local/bin/R","r.lsp.path":"/usr/local/bin/R","r.plot.backend":"auto","r.sessionWatcher":true,"r.bracketedPaste":true,"r.interactive.executionTarget":"terminal"}}}}]'

ENV GDAL_NUM_THREADS="ALL_CPUS" \
    GDAL_CACHEMAX="512" \
    VSI_CACHE="TRUE" \
    GDAL_HTTP_MULTIPLEX="YES"

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get purge -y postgis netcdf-bin \
    && apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install essential geocompkg Imports + VS Code R extension (vscode-R v3+) session/plot/LSP dependencies
# Strip debug symbols from compiled R package shared objects and clean pkgcache in the same layer
RUN R -e "if (!requireNamespace('pak', quietly = TRUE)) install.packages('pak', repos = 'https://cloud.r-project.org/'); pak::pak(c('sf','terra','spData','units','dplyr','languageserver','httpgd','jgd','rstudioapi','processx','ps','later','jsonlite','svglite','methods'), upgrade = FALSE)" \
    && (strip --strip-unneeded /usr/local/lib/R/site-library/*/libs/*.so 2>/dev/null || true) \
    && rm -rf /usr/local/lib/R/site-library/*/doc /tmp/* /root/.cache/R/pkgcache /var/lib/apt/lists/*

# Install arf (modern Rust-based R console used by vscode-R persistent interactive sessions)
RUN wget -qO- https://github.com/eitsupi/arf/releases/latest/download/arf-console-installer.sh | env CARGO_DIST_FORCE_INSTALL_DIR=/usr/local sh \
    && /usr/local/bin/arf --version

# Disable inline RMarkdown/Quarto chunk output in RStudio
RUN echo '{' > /etc/rstudio/rstudio-prefs.json \
    && echo '    "rmd_chunk_output_inline": false' >> /etc/rstudio/rstudio-prefs.json \
    && echo '}' >> /etc/rstudio/rstudio-prefs.json

# Configure Rprofile.site for VS Code / GitHub Codespaces (vscode-R v3+ compatible)
RUN echo 'if (interactive() && (Sys.getenv("TERM_PROGRAM") == "vscode" || Sys.getenv("CODESPACES") == "true")) {' >> /usr/local/lib/R/etc/Rprofile.site \
    && echo '  options(sess.quiet = TRUE)' >> /usr/local/lib/R/etc/Rprofile.site \
    && echo '  if (!requireNamespace("jgd", quietly = TRUE) && requireNamespace("httpgd", quietly = TRUE)) {' >> /usr/local/lib/R/etc/Rprofile.site \
    && echo '    options(device = httpgd::hgd)' >> /usr/local/lib/R/etc/Rprofile.site \
    && echo '  }' >> /usr/local/lib/R/etc/Rprofile.site \
    && echo '}' >> /usr/local/lib/R/etc/Rprofile.site
