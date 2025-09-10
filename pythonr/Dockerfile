FROM ghcr.io/geocompx/python

# Install R and locales
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    libtcl8.6 \
    libtk8.6 \
    locales \
    && locale-gen C.UTF-8 \
    && rm -rf /var/lib/apt/lists/*

ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8

RUN wget https://github.com/rocker-org/rocker-versioned2/raw/refs/heads/master/scripts/install_R_source.sh
RUN bash install_R_source.sh

RUN apt-get update && apt-get install -y --no-install-recommends \
    # rspatial deps:
    libgdal-dev \
    libproj-dev \
    libudunits2-dev \
    libspatialindex-dev \
    libabsl-dev \
    libgeos-dev \
    libsqlite3-dev \
    libtiff-dev \
    libjpeg-dev \
    libpng-dev \
    zlib1g-dev \
    libfontconfig1-dev \
    libfreetype6-dev \
    build-essential \
    libharfbuzz-dev \
    libfribidi-dev \
    libv8-dev \
    libmagick++-dev \
    cmake \
    && rm -rf /var/lib/apt/lists/*

# Install ragg and its dependencies for high-quality headless graphics
RUN R -e "install.packages(c('ragg', 'systemfonts', 'textshaping'))"

# Configure R to use ragg as the default graphics device
RUN mkdir -p /etc/R && \
    echo "options(repos = c(CRAN = 'https://cloud.r-project.org'))" > /etc/R/Rprofile.site && \
    echo "if (requireNamespace('ragg', quietly = TRUE)) { options(device = ragg::agg_png) }" >> /etc/R/Rprofile.site && \
    echo 'options(Ncpus = parallel::detectCores())' >> /etc/R/Rprofile.site

# Install sf:
RUN R -e "install.packages('sf', repos = 'https://cloud.r-project.org')"
# Install remotes for GitHub installs:
RUN R -e "install.packages('remotes', repos = 'https://cloud.r-project.org')"
# Install bookdown for book building:
RUN R -e "install.packages('bookdown', repos = 'https://cloud.r-project.org')"
# Install geocompx:
RUN R -e "install.packages('geocompkg', repos = c('https://geocompx.r-universe.dev', 'https://cloud.r-project.org'), dependencies = TRUE, force = TRUE)"

# # build the book
# RUN wget https://github.com/geocompx/geocompr/archive/main.zip && \
#     unzip main.zip && \
#     mv geocompr-main geocompr && \
#     rm main.zip
# RUN Rscript -e 'bookdown::render_book("geocompr", output_format = "bookdown::gitbook", clean = FALSE)'
