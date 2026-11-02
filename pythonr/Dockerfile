FROM ghcr.io/geocompx/python:latest

LABEL org.opencontainers.image.authors="Robin Lovelace <rob00x@gmail.com>" \
      org.opencontainers.image.source="https://github.com/geocompx/docker" \
      devcontainer.metadata='[{"customizations":{"vscode":{"extensions":["REditorSupport.r","Posit.air-vscode","quarto.quarto","ms-python.python"],"settings":{"r.rterm.linux":"/usr/local/bin/R","r.rpath.linux":"/usr/local/bin/R","r.lsp.path":"/usr/local/bin/R","r.plot.backend":"auto","r.sessionWatcher":true,"r.bracketedPaste":true,"r.interactive.executionTarget":"terminal"}}}}]'

# Install R from Posit's precompiled Debian repository (auto-detecting Debian 12 bookworm vs Debian 13 trixie)
# along with multi-threaded OpenBLAS and required C/C++ runtime/header libraries using --no-install-recommends
ARG R_VERSION=4.6.2
RUN . /etc/os-release && \
    if [ "${VERSION_ID}" = "12" ]; then R_VER="4.6.0"; else R_VER="${R_VERSION}"; fi && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        curl \
        libdeflate0 \
        locales \
        xz-utils && \
    curl -fSL -o /tmp/r.deb "https://cdn.posit.co/r/debian-${VERSION_ID}/pkgs/r-${R_VER}_1_$(dpkg --print-architecture).deb" && \
    apt-get install -y --no-install-recommends /tmp/r.deb \
        libopenblas0-pthread \
        libopenblas-dev \
        liblapack-dev \
        libomp-dev \
        gfortran \
        libudunits2-dev \
        libgdal-dev \
        libgeos-dev \
        libproj-dev \
        libglpk40 \
        libglpk-dev \
        libcurl4-openssl-dev \
        libssl-dev \
        libxml2-dev \
        libfontconfig1-dev \
        libfreetype6-dev \
        libfribidi-dev \
        libharfbuzz-dev \
        libgit2-dev \
        libmagick++-dev \
        libnode-dev \
        libcairo2-dev \
        libx11-dev \
        libuv1-dev \
        libabsl-dev \
    && ln -sfn "/opt/R/${R_VER}" /opt/R/current \
    && ln -sfn /opt/R/current/bin/R /usr/local/bin/R \
    && ln -sfn /opt/R/current/bin/Rscript /usr/local/bin/Rscript \
    && ln -sfn /opt/quarto/bin/tools/pandoc /usr/local/bin/pandoc \
    && rm -rf /tmp/r.deb /var/lib/apt/lists/*

ENV PATH="/opt/R/current/bin:/usr/local/bin:${PATH}" \
    QUARTO_PYTHON="/usr/local/bin/python" \
    RETICULATE_PYTHON="/usr/local/bin/python" \
    GDAL_NUM_THREADS="ALL_CPUS" \
    GDAL_CACHEMAX="512" \
    VSI_CACHE="TRUE" \
    GDAL_HTTP_MULTIPLEX="YES" \
    PYOGRIO_USE_ARROW="1"

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
RUN curl --proto '=https' --tlsv1.2 -LsSf https://github.com/eitsupi/arf/releases/latest/download/arf-console-installer.sh | env CARGO_DIST_FORCE_INSTALL_DIR=/usr/local sh \
    && /usr/local/bin/arf --version

# Install pak + geocompkg (including Suggests) + VS Code R extension (vscode-R v3+) dependencies
# with pkg.sysreqs = FALSE (all required C/C++ runtime libs are installed above with --no-install-recommends)
# and strip debug symbols from compiled R shared objects in the same layer
RUN R -e "install.packages('pak')" && \
    Rscript -e "options(pkg.sysreqs = FALSE, repos = c(geocompx = 'https://geocompx.r-universe.dev', mlrorg = 'https://mlr-org.r-universe.dev', getOption('repos'))); pak::pak(c('sf', 'geocompkg', 'languageserver', 'httpgd', 'jgd', 'rstudioapi', 'processx', 'ps', 'later', 'jsonlite', 'svglite', 'reticulate'), dependencies = TRUE)" && \
    strip --strip-debug /opt/R/current/lib/R/library/*/libs/*.so 2>/dev/null || true && \
    ln -sf /usr/local/bin/python /usr/bin/python3 && \
    ln -sf /usr/local/bin/python /usr/bin/python && \
    rm -rf /tmp/* /root/.cache/R/pkgcache /var/lib/apt/lists/*
