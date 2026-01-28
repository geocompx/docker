FROM ghcr.io/geocompx/minimal
RUN R -e "install.packages('geocompkg', upgrade = TRUE, dependencies = TRUE, force = TRUE, repos = c('https://geocompx.r-universe.dev', 'https://mlr-org.r-universe.dev', options('repos')))"
