FROM ghcr.io/geocompx/python:latest

LABEL org.opencontainers.image.authors="Robin Lovelace <rob00x@gmail.com>" \
      org.opencontainers.image.source="https://github.com/geocompx/docker" \
      devcontainer.metadata='[{"customizations":{"vscode":{"extensions":["REditorSupport.r","Posit.air-vscode","quarto.quarto","ms-python.python"],"settings":{"r.rterm.linux":"/usr/local/bin/R","r.rpath.linux":"/usr/local/bin/R","r.lsp.path":"/usr/local/bin/R","r.plot.backend":"auto","r.sessionWatcher":true,"r.bracketedPaste":true,"r.interactive.executionTarget":"terminal"}}}}]'

RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    libdeflate0 \
    locales \
    xz-utils \
    && rm -rf /var/lib/apt/lists/*

# Install R from Posit's precompiled Debian repository (auto-detecting Debian 12 bookworm vs Debian 13 trixie)
ARG R_VERSION=4.6.2
RUN . /etc/os-release && \
    if [ "${VERSION_ID}" = "12" ]; then R_VER="4.6.0"; else R_VER="${R_VERSION}"; fi && \
    curl -fSL -o /tmp/r.deb "https://cdn.posit.co/r/debian-${VERSION_ID}/pkgs/r-${R_VER}_1_$(dpkg --print-architecture).deb" && \
    apt-get update && \
    apt-get install -y /tmp/r.deb \
        libblas-dev \
        liblapack-dev \
        libomp-dev \
        gfortran \
        libudunits2-dev \
        libgdal-dev \
        libgeos-dev \
        libproj-dev \
        libglpk40 \
    && ln -sfn "/opt/R/${R_VER}" /opt/R/current \
    && ln -sfn /opt/R/current/bin/R /usr/local/bin/R \
    && ln -sfn /opt/R/current/bin/Rscript /usr/local/bin/Rscript \
    && rm -rf /tmp/r.deb /var/lib/apt/lists/*

ENV PATH="/opt/R/current/bin:${PATH}"

# Make Python visible on standard path for R's reticulate
RUN update-alternatives --install /usr/bin/python3 python3 /usr/local/bin/python 10

# Configure Rprofile.site and /root/.Rprofile with P3M binary repository and HTTPUserAgent
# so both pak and base install.packages() receive precompiled Linux binary packages from P3M
RUN . /etc/os-release && \
    mkdir -p /etc/R /opt/R/current/lib/R/etc /root && \
    cat <<EOF > /opt/R/current/lib/R/etc/Rprofile.site
options(
  repos = c(CRAN = "https://p3m.dev/cran/__linux__/${VERSION_CODENAME}/latest"),
  download.file.method = "libcurl",
  HTTPUserAgent = sprintf("R/%s R (%s)", getRversion(), paste(getRversion(), R.version["platform"], R.version["arch"], R.version["os"])),
  sess.quiet = TRUE
)
EOF
RUN cp /opt/R/current/lib/R/etc/Rprofile.site /etc/R/Rprofile.site && \
    cp /opt/R/current/lib/R/etc/Rprofile.site /root/.Rprofile

# Install arf (modern Rust-based R console used by vscode-R persistent sessions)
RUN curl --proto '=https' --tlsv1.2 -LsSf https://github.com/eitsupi/arf/releases/latest/download/arf-console-installer.sh | env ARF_INSTALL_DIR=/usr/local/bin sh

# Install pak from precompiled binary
RUN R -e "install.packages('pak')"

# Install geocompkg (including Suggests) + VS Code R extension (vscode-R v3+) dependencies
# using pak so system requirements and precompiled P3M/r-universe binaries are resolved in parallel
RUN Rscript -e "options(repos = c(geocompx = 'https://geocompx.r-universe.dev', mlrorg = 'https://mlr-org.r-universe.dev', getOption('repos'))); pak::pak(c('sf', 'geocompkg', 'languageserver', 'httpgd', 'jgd', 'rstudioapi', 'processx', 'ps', 'later', 'jsonlite', 'svglite', 'reticulate'), dependencies = TRUE)" && \
    rm -rf /tmp/* /root/.cache/R/pkgcache
