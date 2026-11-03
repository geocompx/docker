# Slim custom geospatial image built from rocker/r-ver, without RStudio or heavy CLI tools
ARG R_VER=4.6.2
FROM rocker/r-ver:${R_VER}

ENV GDAL_NUM_THREADS="ALL_CPUS" \
    GDAL_CACHEMAX="512" \
    VSI_CACHE="TRUE" \
    GDAL_HTTP_MULTIPLEX="YES"

# System dependencies: keep only what sf/terra/spData need at runtime/build time + multi-threaded OpenBLAS
# Remove unused third-party static .a archives in the same layer
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        libopenblas0-pthread \
        libgdal-dev \
        libgeos-dev \
        libproj-dev \
        libudunits2-dev \
        libssl-dev \
    && find /usr/lib/*-linux-gnu -name "*.a" ! -name "*nonshared*" ! -name "libc.a" ! -name "libm.a" -delete \
    && rm -rf /usr/share/doc/* /usr/share/man/* /var/lib/apt/lists/*

# R packages: geocompx/geocompkg Imports + VS Code R extension (vscode-R v3+) dependencies
# Strip binary .so files and static vignettes in the same layer to reduce image size
ARG NCPUS=-1
RUN install2.r --error --skipmissing --skipinstalled -n "${NCPUS}" \
        sf terra spData units dplyr methods languageserver httpgd jgd rstudioapi processx ps later jsonlite svglite \
    && Rscript -e "js <- jsonlite::fromJSON('https://api.github.com/repos/REditorSupport/vscode-R/releases/latest'); u <- js[['assets']][['browser_download_url']][grepl('\\.vsix$', js[['assets']][['browser_download_url']])][1]; tf <- tempfile(fileext = '.vsix'); td <- tempfile(); download.file(u, tf, mode = 'wb', quiet = TRUE); f <- unzip(tf, list = TRUE)[['Name']]; unzip(tf, files = f[startsWith(f, 'extension/dist/resources/sess/')], exdir = td); install.packages(file.path(td, 'extension/dist/resources/sess'), repos = NULL, type = 'source', quiet = TRUE); unlink(c(tf, td), recursive = TRUE)" \
    && (find /usr/local/lib/R/site-library/*/libs -name '*.so' -exec strip --strip-unneeded {} + 2>/dev/null || true) \
    && rm -rf /usr/local/lib/R/site-library/*/doc /tmp/downloaded_packages

# Default command
CMD ["R"]
