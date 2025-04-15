FROM rocker/binder
USER root
RUN R -e "install.packages('geocompkg', upgrade = TRUE, dependencies = TRUE, force = TRUE, repos = c('https://geocompr.r-universe.dev', 'https://mlr-org.r-universe.dev', 'https://cloud.r-project.org'))"
USER $NB_USER