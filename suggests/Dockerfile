FROM ghcr.io/geocompx/minimal
RUN apt-get update && apt-get install -y --no-install-recommends \
    libglpk40 \
    nodejs \
    && rm -rf /var/lib/apt/lists/*
RUN R -e "install.packages('geocompkg', upgrade = TRUE, dependencies = TRUE, force = TRUE, repos = c('https://geocompx.r-universe.dev', 'https://mlr-org.r-universe.dev', options('repos')))"
