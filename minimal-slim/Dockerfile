# Slim custom geospatial image built from rocker/r-ver, without RStudio or heavy CLI tools
ARG R_VER=4.4.2
FROM rocker/r-ver:${R_VER}

# System dependencies: keep only what sf/terra/spData need at runtime/build time
# Omitting: gdal-bin, netcdf-bin, postgis, Jupyter, pandoc, TeX, Java
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        libgdal-dev \
        libgeos-dev \
        libproj-dev \
        libudunits2-dev \
        libssl-dev \
    && rm -rf /var/lib/apt/lists/*

# R packages: geocompx/geocompkg Imports only (sf, terra, spData, units, dplyr, methods, languageserver)
# Using install2.r from rocker-versioned2 style (lightweight, no extra system deps)
ARG NCPUS=-1
RUN install2.r --error --skipmissing --skipinstalled -n "${NCPUS}" \
        sf terra spData units dplyr methods languageserver \
    && rm -rf /tmp/downloaded_packages

# Strip binary .so files from RSPM installs
RUN find /usr/local/lib/R/site-library/*/libs -name '*.so' -exec strip --strip-unneeded {} + 2>/dev/null || true

# Default command
CMD ["R"]
