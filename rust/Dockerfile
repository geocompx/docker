FROM ghcr.io/geocompx/docker:suggests
# od2net R package: https://urban-analytics-technology-platform.github.io/od2net/r/
RUN R -e "remotes::install_github('Urban-Analytics-Technology-Platform/od2net', subdir = 'r', upgrade = TRUE, dependencies = TRUE)"
# acteng/netgen:
RUN R -e "remotes::install_github('acteng/netgen', upgrade = TRUE, dependencies = TRUE)"
# robinlovelace/simodels:
RUN R -e "remotes::install_github('robinlovelace/simodels', upgrade = TRUE, dependencies = TRUE)"

RUN curl https://sh.rustup.rs -sSf | sh -s -- -y \
  && export PATH="$HOME/.cargo/bin:$PATH" \
  && echo 'export PATH="$HOME/.cargo/bin:$PATH"' >> ~/.profile \
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

# RUN R -e "remotes::install_github('geocompx/geocompkg', upgrade = TRUE, dependencies = TRUE)"
RUN chown -Rv rstudio /home/rstudio/geocompr


