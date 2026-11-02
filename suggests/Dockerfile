FROM ghcr.io/geocompx/minimal
RUN apt-get update && apt-get install -y --no-install-recommends \
    libglpk40 \
    nodejs \
    && rm -rf /var/lib/apt/lists/*
RUN R -e "options(repos = c(geocompx = 'https://geocompx.r-universe.dev', mlrorg = 'https://mlr-org.r-universe.dev', getOption('repos'))); pak::pak('geocompkg', dependencies = TRUE, upgrade = TRUE)"
