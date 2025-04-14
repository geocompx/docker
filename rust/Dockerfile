FROM ghcr.io/geocompx/docker:suggests

# Define ARG for compatibility
ARG GITHUB_PAT

# od2net R package: https://urban-analytics-technology-platform.github.io/od2net/r/
RUN --mount=type=secret,id=GITHUB_PAT \
    GITHUB_PAT=$(cat /run/secrets/GITHUB_PAT 2>/dev/null || echo "") \
    R -e "Sys.setenv(GITHUB_PAT=Sys.getenv('GITHUB_PAT')); remotes::install_github('Urban-Analytics-Technology-Platform/od2net', subdir = 'r', upgrade = TRUE, dependencies = TRUE)"

# acteng/netgen:
RUN --mount=type=secret,id=GITHUB_PAT \
    GITHUB_PAT=$(cat /run/secrets/GITHUB_PAT 2>/dev/null || echo "") \
    R -e "Sys.setenv(GITHUB_PAT=Sys.getenv('GITHUB_PAT')); remotes::install_github('acteng/netgen', upgrade = TRUE, dependencies = TRUE)"

# robinlovelace/simodels:
RUN --mount=type=secret,id=GITHUB_PAT \
    GITHUB_PAT=$(cat /run/secrets/GITHUB_PAT 2>/dev/null || echo "") \
    R -e "Sys.setenv(GITHUB_PAT=Sys.getenv('GITHUB_PAT')); remotes::install_github('robinlovelace/simodels', upgrade = TRUE, dependencies = TRUE)"

RUN curl https://sh.rustup.rs -sSf | sh -s -- --default-toolchain nightly -y \
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
  && sudo make install \
  && tippecanoe --version \
  && echo "deb http://archive.ubuntu.com/ubuntu/ jammy main restricted" >> /etc/apt/sources.list \
  && apt-get update \
  && sudo apt-get install -y osmium-tool

# Ensure od2net is available in the PATH:
RUN ln -s /root/.cargo/bin/od2net /usr/local/bin/od2net
