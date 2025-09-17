FROM ghcr.io/geocompx/python

# Note: previously this image built on Rocker but install_R_ppa.sh fails on Debian 
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    locales \
    && rm -rf /var/lib/apt/lists/*
# Manual R installation: Download and install R DEB for Debian 12
ARG R_VERSION=4.5.1
RUN curl -O https://cdn.posit.co/r/debian-12/pkgs/r-${R_VERSION}_1_$(dpkg --print-architecture).deb && \
    apt-get update && \
    apt-get install -y --no-install-recommends ./r-${R_VERSION}_1_$(dpkg --print-architecture).deb && \
    rm r-${R_VERSION}_1_$(dpkg --print-architecture).deb

ENV PATH="/opt/R/${R_VERSION}/bin:${PATH}"
ENV R_PKG_TYPE=binary

RUN mkdir -p /etc/R && \
    echo "options(repos = c(CRAN = 'https://packagemanager.posit.co/cran/__linux__/bookworm/latest'))" > /etc/R/Rprofile.site && \
    mkdir -p /root && \
    echo "options(repos = c(CRAN = 'https://packagemanager.posit.co/cran/__linux__/bookworm/latest'))" > /root/.Rprofile

# Install pak
RUN R -e "install.packages('pak')"

# # Install packages with pak (binaries from RSPM)
RUN Rscript -e "pak::pak('sf')"

RUN R -e "install.packages('geocompkg', repos = c('https://geocompx.r-universe.dev', 'https://packagemanager.posit.co/cran/__linux__/bookworm/latest'), dependencies = TRUE, force = TRUE)"

# # Uncomment the following to test building the book:
# RUN wget https://github.com/geocompx/geocompr/archive/main.zip && \
#     unzip main.zip && \
#     mv geocompr-main geocompr && \
#     rm main.zip
# RUN Rscript -e 'bookdown::render_book("geocompr", output_format = "bookdown::gitbook", clean = FALSE)'
