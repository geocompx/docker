FROM ghcr.io/geocompx/python:latest

LABEL org.opencontainers.image.authors="Robin Lovelace <rob00x@gmail.com>" \
      org.opencontainers.image.source="https://github.com/geocompx/docker" \
      devcontainer.metadata='[{"customizations":{"vscode":{"extensions":["REditorSupport.r","Posit.air-vscode","quarto.quarto","ms-python.python"],"settings":{"r.rterm.linux":"/usr/local/bin/R","r.rpath.linux":"/usr/local/bin/R","r.lsp.path":"/usr/local/bin/R","r.plot.backend":"auto","r.sessionWatcher":true,"r.bracketedPaste":true,"r.interactive.executionTarget":"terminal"}}}}]'

# Contender 2 (Ultra-Slim Runtime): Posit R (which includes gcc/g++/gfortran/make/openblas-dev) + exact runtime .so libraries
# without 650 MB of libboost1.83-dev / libllvm19 / libspatialite-dev / python3.13 / third-party static .a archives
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
        liblapack3 \
        libgdal36 \
        libgeos-c1t64 \
        libproj25 \
        libudunits2-0 \
        libglpk40 \
        libmagick++-7.q16-5 \
        libnode115 \
        libgit2-1.9 \
        libabsl20240722 \
        libuv1t64 \
        libfribidi0 \
        libharfbuzz0b \
        libtiffxx6 \
    && find /usr/lib/*-linux-gnu -name "*.a" ! -name "*nonshared*" ! -name "libc.a" ! -name "libm.a" -delete \
    && ln -sfn "/opt/R/${R_VER}" /opt/R/current \
    && ln -sfn /opt/R/current/bin/R /usr/local/bin/R \
    && ln -sfn /opt/R/current/bin/Rscript /usr/local/bin/Rscript \
    && ln -sfn /opt/quarto/bin/tools/pandoc /usr/local/bin/pandoc \
    && rm -rf /tmp/r.deb /usr/share/doc/* /usr/share/man/* /var/lib/apt/lists/*

ENV PATH="/opt/R/current/bin:/usr/local/bin:${PATH}" \
    QUARTO_PYTHON="/usr/local/bin/python" \
    RETICULATE_PYTHON="/usr/local/bin/python" \
    GDAL_NUM_THREADS="ALL_CPUS" \
    GDAL_CACHEMAX="512" \
    VSI_CACHE="TRUE" \
    GDAL_HTTP_MULTIPLEX="YES" \
    PYOGRIO_USE_ARROW="1"

# Configure Rprofile.site and /root/.Rprofile with P3M binary repository and HTTPUserAgent
RUN . /etc/os-release && \
    mkdir -p /etc/R /opt/R/current/lib/R/etc /root && \
    cat <<EOF > /opt/R/current/lib/R/etc/Rprofile.site
options(
  repos = c(CRAN = "https://p3m.dev/cran/__linux__/${VERSION_CODENAME}/latest"),
  pkg.sysreqs = FALSE,
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

# Parallel source build via MAKEFLAGS, strip .so debug symbols, prune static vignettes & googlePolylines Boost header cache,
# hardlink duplicate files, and assert zero missing shared libraries across all installed R .so objects
RUN export MAKEFLAGS="-j$(nproc)" && \
    R -e "install.packages('pak')" && \
    Rscript -e "options(pkg.sysreqs = FALSE, repos = c(geocompx = 'https://geocompx.r-universe.dev', mlrorg = 'https://mlr-org.r-universe.dev', getOption('repos'))); pak::pak(c('sf', 'geocompkg', 'languageserver', 'httpgd', 'jgd', 'rstudioapi', 'processx', 'ps', 'later', 'jsonlite', 'svglite', 'reticulate'), dependencies = TRUE)" && \
    ! (LD_LIBRARY_PATH="/opt/R/current/lib/R/lib:${LD_LIBRARY_PATH}" ldd /opt/R/current/lib/R/library/*/libs/*.so 2>/dev/null | grep "not found") && \
    (strip --strip-unneeded /opt/R/current/lib/R/library/*/libs/*.so 2>/dev/null || true) && \
    rm -rf /opt/R/current/lib/R/library/*/doc \
           /opt/R/current/lib/R/library/googlePolylines/i \
           /opt/R/current/lib/R/doc && \
    python -c 'import os,hashlib; seen={}; [([os.unlink(p),os.link(seen[h],p)] if h in seen else seen.setdefault(h,p)) for r,_,fs in os.walk("/opt/R/current/lib/R/library") for f in fs if not os.path.islink(p:=os.path.join(r,f)) and (s:=os.path.getsize(p))>4096 and (h:=(s,hashlib.sha256(open(p,"rb").read()).hexdigest()))]' && \
    ln -sf /usr/local/bin/python /usr/bin/python3 && \
    ln -sf /usr/local/bin/python /usr/bin/python && \
    rm -rf /tmp/* /root/.cache/R/pkgcache /var/lib/apt/lists/*
