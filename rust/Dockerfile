FROM ghcr.io/geocompx/suggests

# od2net R package: https://urban-analytics-technology-platform.github.io/od2net/r/
RUN git clone --depth 1 https://github.com/a-b-street/od2net.git /tmp/od2net \
  && R -e "if (!requireNamespace('pak', quietly = TRUE)) install.packages('pak', repos = 'https://cloud.r-project.org/'); pak::local_install('/tmp/od2net/r', upgrade = TRUE, dependencies = TRUE)" \
  && rm -rf /tmp/od2net /root/.cache/R/pkgcache

# robinlovelace/simodels:
RUN R -e "if (!requireNamespace('pak', quietly = TRUE)) install.packages('pak', repos = 'https://cloud.r-project.org/'); pak::pak('robinlovelace/simodels', upgrade = TRUE, dependencies = TRUE)" \
  && rm -rf /tmp/* /root/.cache/R/pkgcache

RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    osmium-tool \
  && curl https://sh.rustup.rs -sSf | sh -s -- --default-toolchain stable --profile minimal -y \
  && export PATH="$HOME/.cargo/bin:$PATH" \
  && echo 'export PATH="$HOME/.cargo/bin:$PATH"' >> ~/.profile \
  && ln -s /root/.cargo/bin/cargo /usr/local/bin/cargo \
  && ln -s /root/.cargo/bin/rustc /usr/local/bin/rustc \
  && cargo install --locked --git https://github.com/Urban-Analytics-Technology-Platform/od2net \
  && ln -s /root/.cargo/bin/od2net /usr/local/bin/od2net \
  && git clone --depth 1 https://github.com/felt/tippecanoe.git /tmp/tippecanoe \
  && make -C /tmp/tippecanoe -j"$(nproc)" \
  && make -C /tmp/tippecanoe install \
  && tippecanoe --version \
  && rm -rf /tmp/tippecanoe /root/.cargo/registry /root/.cargo/git /var/lib/apt/lists/*
