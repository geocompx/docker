FROM ghcr.io/geocompx/minimal
RUN echo "options(repos = c(" \
    "geocompr = 'https://geocompr.r-universe.dev'," \
    "mlr3 = 'https://mlr3-org.r-universe.dev'," \
    "cran = 'https://cloud.r-project.org'))" >> /usr/local/lib/R/etc/Rprofile.site
RUN R -e "install.packages('geocompkg', upgrade = TRUE, dependencies = TRUE, force = TRUE)"
