FROM rocker/binder:4.4.2
USER root
RUN mkdir /tmp/downloaded_packages
RUN /rocker_scripts/install_geospatial.sh
# Back to rstudio user
USER rstudio
RUN R -e "install.packages('geocompkg', upgrade = TRUE, dependencies = TRUE, force = TRUE, repos = c('https://geocompr.r-universe.dev', 'https://mlr-org.r-universe.dev', options('repos')))"
