FROM ghcr.io/geocompx/python

# Install R and locales
# Fails on Debian (ubuntu PPA does not support Debian):
# RUN wget https://raw.githubusercontent.com/rocker-org/rocker-versioned2/refs/heads/master/scripts/install_R_ppa.sh
# RUN bash install_R_ppa.sh
# bash -c "$(curl -L https://rstd.io/r-install)"
# Install curl:
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
RUN Rscript -e "pak::pkg_install('sf')"

# RUN wget https://raw.githubusercontent.com/rocker-org/rocker-versioned2/refs/heads/master/scripts/setup_R.sh
# RUN bash setup_R.sh

# RUN wget https://github.com/rocker-org/rocker-versioned2/raw/refs/heads/master/scripts/install_R_source.sh
# RUN bash install_R_source.sh

# RUN apt-get update && apt-get install -y --no-install-recommends \
#     # rspatial deps:
#     libgdal-dev \
#     libproj-dev \
#     libudunits2-dev \
#     libspatialindex-dev \
#     libabsl-dev \
#     libgeos-dev \
#     libsqlite3-dev \
#     libtiff-dev \
#     libjpeg-dev \
#     libpng-dev \
#     zlib1g-dev \
#     libfontconfig1-dev \
#     libfreetype6-dev \
#     build-essential \
#     libharfbuzz-dev \
#     libfribidi-dev \
#     libv8-dev \
#     libmagick++-dev \
#     cmake \
#     && rm -rf /var/lib/apt/lists/*

# # Install ragg and its dependencies for high-quality headless graphics
# RUN R -e "install.packages(c('ragg', 'systemfonts', 'textshaping'))"

# Configure R to use ragg as the default graphics device
# RUN mkdir -p /etc/R && \
#     echo "options(repos = c(CRAN = 'https://cloud.r-project.org'))" > /etc/R/Rprofile.site && \
#     echo "if (requireNamespace('ragg', quietly = TRUE)) { options(device = ragg::agg_png) }" >> /etc/R/Rprofile.site && \
#     echo 'options(Ncpus = parallel::detectCores())' >> /etc/R/Rprofile.site

# # Install sf:
# RUN R -e "install.packages('sf', repos = 'https://cloud.r-project.org')"
# # Install remotes for GitHub installs:
# RUN R -e "install.packages('remotes', repos = 'https://cloud.r-project.org')"
# # Install bookdown for book building:
# RUN R -e "install.packages('bookdown', repos = 'https://cloud.r-project.org')"
# # Install geocompx:
RUN R -e "install.packages('geocompkg', repos = c('https://geocompx.r-universe.dev', 'https://packagemanager.posit.co/cran/__linux__/bookworm/latest'), dependencies = TRUE, force = TRUE)"

# # build the book
# RUN wget https://github.com/geocompx/geocompr/archive/main.zip && \
#     unzip main.zip && \
#     mv geocompr-main geocompr && \
#     rm main.zip
# RUN Rscript -e 'bookdown::render_book("geocompr", output_format = "bookdown::gitbook", clean = FALSE)'
