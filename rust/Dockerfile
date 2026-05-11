FROM ghcr.io/geocompx/suggests

# od2net R package: https://urban-analytics-technology-platform.github.io/od2net/r/
RUN git clone --depth 1 https://github.com/a-b-street/od2net.git /tmp/od2net \
  && R -e "if (!requireNamespace('pak', quietly = TRUE)) install.packages('pak', repos = 'https://cloud.r-project.org/'); pak::local_install('/tmp/od2net/r', upgrade = TRUE, dependencies = TRUE)" \
  && rm -rf /tmp/od2net
# robinlovelace/simodels:
RUN R -e "if (!requireNamespace('pak', quietly = TRUE)) install.packages('pak', repos = 'https://cloud.r-project.org/'); pak::pak('robinlovelace/simodels', upgrade = TRUE, dependencies = TRUE)"

RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    && rm -rf /var/lib/apt/lists/* \
  && curl https://sh.rustup.rs -sSf | sh -s -- --default-toolchain stable -y \
  && export PATH="$HOME/.cargo/bin:$PATH" \
  && echo 'export PATH="$HOME/.cargo/bin:$PATH"' >> ~/.profile \
  # Also make cargo available and rustc available with ln -s:
  && ln -s /root/.cargo/bin/cargo /usr/local/bin/cargo \
  && ln -s /root/.cargo/bin/rustc /usr/local/bin/rustc \
  && cargo install --locked --git https://github.com/Urban-Analytics-Technology-Platform/od2net \
  && cd /tmp \
  && git clone https://github.com/felt/tippecanoe.git \
  && cd tippecanoe \
  && make -j \
  && make install \
  && tippecanoe --version \
  && echo "deb http://archive.ubuntu.com/ubuntu/ jammy main restricted" >> /etc/apt/sources.list \
  && apt-get update \
  && apt-get install -y osmium-tool

# Ensure od2net is available in the PATH:
RUN ln -s /root/.cargo/bin/od2net /usr/local/bin/od2net
