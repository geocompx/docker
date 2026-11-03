FROM ghcr.io/geocompx/minimal
RUN apt-get update && apt-get install -y --no-install-recommends \
    libglpk40 \
    nodejs \
    && rm -rf /var/lib/apt/lists/*
RUN export MAKEFLAGS="-j$(nproc)" \
    && R -e "options(repos = c(geocompx = 'https://geocompx.r-universe.dev', mlrorg = 'https://mlr-org.r-universe.dev', getOption('repos'))); pak::pak('geocompkg', dependencies = TRUE, upgrade = TRUE)" \
    && (strip --strip-unneeded /usr/local/lib/R/site-library/*/libs/*.so 2>/dev/null || true) \
    && rm -rf /usr/local/lib/R/site-library/*/doc \
              /usr/local/lib/R/site-library/googlePolylines/i \
              /tmp/* /root/.cache/R/pkgcache /var/lib/apt/lists/*
