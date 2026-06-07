ARG ROCKER_GEOSPATIAL_IMAGE=rocker/geospatial:latest
FROM ${ROCKER_GEOSPATIAL_IMAGE}

# Drop packages that are not needed for R geospatial work
# (keep libgdal-dev/libgeos-dev/libproj-dev — needed by sf/terra)
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get purge -y postgis netcdf-bin \
    && apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install only the essential geocompkg Imports (not Suggests) to keep the
# image lean. The full geocompkg Suggests set (60+ packages) is available
# via the `suggests` image or users can install on demand.
RUN R -e "if (!requireNamespace('pak', quietly = TRUE)) install.packages('pak', repos = 'https://cloud.r-project.org/'); pak::pak(c('sf','terra','spData','units','dplyr','languageserver','methods'), upgrade = FALSE)"

# Strip binary shared libraries from RSPM packages to reduce final image size
# See https://github.com/rocker-org/rocker-versioned2/issues/340
RUN strip /usr/local/lib/R/site-library/*/libs/*.so

# Set RStudio preferences — no inline code
RUN echo '{' > /etc/rstudio/rstudio-prefs.json \
    && echo '    "rmd_chunk_output_inline": false' >> /etc/rstudio/rstudio-prefs.json \
    && echo '}' >> /etc/rstudio/rstudio-prefs.json

# Clean up apt caches
RUN rm -rf /var/lib/apt/lists/*
