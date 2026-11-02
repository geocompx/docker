# Slim custom geospatial image built from rocker/r-ver, without RStudio or heavy CLI tools
ARG R_VER=4.6.2
FROM rocker/r-ver:${R_VER}

ENV GDAL_NUM_THREADS="ALL_CPUS" \
    GDAL_CACHEMAX="512" \
    VSI_CACHE="TRUE" \
    GDAL_HTTP_MULTIPLEX="YES"

# System dependencies: keep only what sf/terra/spData need at runtime/build time + multi-threaded OpenBLAS
# Omitting: gdal-bin, netcdf-bin, postgis, Jupyter, pandoc, TeX, Java
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        libopenblas0-pthread \
        libgdal-dev \
        libgeos-dev \
        libproj-dev \
        libudunits2-dev \
        libssl-dev \
    && rm -rf /var/lib/apt/lists/*

# R packages: geocompx/geocompkg Imports + VS Code R extension (vscode-R v3+) dependencies
# Using install2.r from rocker-versioned2 style (lightweight, no extra system deps)
# Strip binary .so files in the same layer to reduce image size
ARG NCPUS=-1
RUN install2.r --error --skipmissing --skipinstalled -n "${NCPUS}" \
        sf terra spData units dplyr methods languageserver httpgd jgd rstudioapi processx ps later jsonlite svglite \
    && find /usr/local/lib/R/site-library/*/libs -name '*.so' -exec strip --strip-unneeded {} + 2>/dev/null || true \
    && rm -rf /tmp/downloaded_packages

# Default command
CMD ["R"]
