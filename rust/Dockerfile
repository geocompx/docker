FROM ghcr.io/geocompx/docker:suggests
# RUN --mount=type=secret,id=GITHUB_PAT \
#   echo "GITHUB_PAT=$(cat /run/secrets/GITHUB_PAT)" > ~/.Renviron
# RUN R -e "remotes::install_github('geocompr/geocompkg', upgrade = TRUE, dependencies = TRUE, force = TRUE)"

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

# RUN R -e "options(repos = c(geocompr = 'https://geocompr.r-universe.dev', CRAN = 'https://cloud.r-project.org')); install.packages('geocompkg', dependencies = TRUE)"
RUN chown -Rv rstudio /home/rstudio/geocompr
# Set RStudio preferences
# No inline code:
RUN echo '{' >> /etc/rstudio/rstudio-prefs.json
RUN echo '    "rmd_chunk_output_inline": false' >> /etc/rstudio/rstudio-prefs.json
RUN echo '}' >> /etc/rstudio/rstudio-prefs.json
