FROM rocker/binder:latest
RUN R -e "install.packages('geocompkg', upgrade = TRUE, dependencies = TRUE, force = TRUE, repos = c('https://geocompr.r-universe.dev', 'https://mlr-org.r-universe.dev', options('repos')))"
