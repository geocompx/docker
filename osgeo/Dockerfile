FROM rocker/geospatial:dev-osgeo
RUN R -e "if (!requireNamespace('pak', quietly = TRUE)) install.packages('pak', repos = 'https://cloud.r-project.org/'); pak::pak('geocompx/geocompkg', upgrade = TRUE)" \
    && strip --strip-debug /usr/local/lib/R/site-library/*/libs/*.so 2>/dev/null || true \
    && rm -rf /tmp/* /root/.cache/R/pkgcache /var/lib/apt/lists/*

# Set RStudio preferences (no inline code)
RUN printf '{\n    "rmd_chunk_output_inline": false\n}\n' > /etc/rstudio/rstudio-prefs.json
