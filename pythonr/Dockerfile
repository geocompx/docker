FROM ghcr.io/geocompx/python

# Install R
RUN apt-get update && apt-get install -y --no-install-recommends \
    wget \
    ca-certificates \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    libtcl8.6 \
    libtk8.6 \
    # rspatial deps:
    libgdal-dev \
    libproj-dev \
    libudunits2-dev \
    libspatialindex-dev \
    && rm -rf /var/lib/apt/lists/*

# Set up locale for R installation
RUN apt-get update && apt-get install -y locales && locale-gen C.UTF-8 && rm -rf /var/lib/apt/lists/*
ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8

RUN wget https://github.com/rocker-org/rocker-versioned2/raw/refs/heads/master/scripts/install_R_source.sh
RUN bash install_R_source.sh

# Configure rspm
RUN mkdir -p /etc/R
RUN echo 'options(repos = c(CRAN = "https://packagemanager.rstudio.com/all/latest"))' > /etc/R/Rprofile.site
RUN echo 'options(Ncpus = parallel::detectCores())' >> /etc/R/Rprofile.site
# Install sf:
RUN R -e "install.packages('sf')"
# Install geocompx:
RUN R -e "install.packages('geocompkg', upgrade = TRUE, dependencies = TRUE, force = TRUE, repos = c('https://geocompr.r-universe.dev', 'https://mlr-org.r-universe.dev', 'https://cloud.r-project.org'))"

# # build the book
# RUN wget https://github.com/geocompx/geocompr/archive/main.zip && \
#     unzip main.zip && \
#     mv geocompr-main geocompr && \
#     rm main.zip
# RUN Rscript -e 'bookdown::render_book("geocompr", output_format = "bookdown::gitbook", clean = FALSE)'
